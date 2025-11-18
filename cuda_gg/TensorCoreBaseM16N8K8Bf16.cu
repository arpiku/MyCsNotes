
#include <cstdio>
#include <cassert>
#include <cstdint>
#include <random>
#include <cuda_runtime.h>
#include <mma.h>

#define CUDA_CHECK(call)                                                           \
do {                                                                               \
        cudaError_t error = call;                                                  \
        if (error != cudaSuccess) {                                                \
            fprintf(stderr, "CUDA Error: %s at %s:%d\n", cudaGetErrorString(error),\
                    __FILE__, __LINE__);                                           \
            exit(error);                                                           \
        }                                                                          \
} while (0)
#undef NDEBUG

#define MMA_M 16
#define MMA_N 8
#define MMA_K 8

__global__ void k_mmaTensorMatMul(__nv_bfloat16 *inputLayerA_d, __nv_bfloat16 *inputLayerB_d, float *outputLayer_d, int mDim, int nDim, int kDim);

void cpuMatMulReference(const __nv_bfloat16* A,
                        const __nv_bfloat16* B,
                        float* cpuRefC,
                        int M,
                        int N,
                        int K) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            float sum = 0.0f;
            for (int k = 0; k < K; k++) {
                float a_val = static_cast<float>(A[i*K + k]);
                float b_val = static_cast<float>(B[k*N + j]);
                sum += a_val * b_val;
            }
            cpuRefC[i*N + j] = sum;
        }
    }
}

void runner() {
    const int TEST_CASE_COUNT = 7;
    const int TEST_CASES_DIMS[TEST_CASE_COUNT][3] = {{16,16,16}, {512,512,512}, {32,16,32}, {256, 256, 256}, {64, 64, 64} , {64, 32, 32}, {128, 128, 128}};
    const float TOLERANCE  = 0.01;
    const int BLOCK_SIZE = 256;

    std::random_device randomSeedSource; // Automatically configure high quality seed using system info
    std::mt19937 randEngine(randomSeedSource());

    std::uniform_real_distribution<float> randDist(1.0f, 100.0f);

    for (int i = 0; i < TEST_CASE_COUNT; i++) {
        int M = TEST_CASES_DIMS[i][0]; //Number of Rows in Matrix A
        int N = TEST_CASES_DIMS[i][1]; //Number of Columns in Matrix B
        int K = TEST_CASES_DIMS[i][2]; //Number of Columns in Matrix A and Rows in Matrix B

        __nv_bfloat16* A_h =(__nv_bfloat16*)malloc(M * K * sizeof(__nv_bfloat16));
        __nv_bfloat16* B_h =(__nv_bfloat16*)malloc(K * N * sizeof(__nv_bfloat16));

        float* cpuC_h =(float*)malloc(M * N * sizeof(float)); // Reference Matrix space allocation on host
        float* gpuC_h = (float*)malloc(M * N * sizeof(float));// GPU result Matrix space allocation on host

        //Pointers for device memory (GPU)
        __nv_bfloat16* A_d;
        __nv_bfloat16* B_d;
        float* C_d;

        //Populating input matrices with random values
        for (int i = 0; i < M * K; i++) {
            float val = randDist(randEngine);
            A_h[i] = __nv_bfloat16(val);
        }

        for (int i = 0; i < K * N; i++) {
            float val = randDist(randEngine);
            B_h[i] = __nv_bfloat16(val);
        }

        // Use a CUDA stream for asynchronous operations
        cudaStream_t stream;
        CUDA_CHECK(cudaStreamCreate(&stream));

        // Allocate the memory on the device
        CUDA_CHECK(cudaMallocAsync(&A_d, M * K * sizeof(__nv_bfloat16), stream));
        CUDA_CHECK(cudaMallocAsync(&B_d, K * N * sizeof(__nv_bfloat16), stream));
        CUDA_CHECK(cudaMallocAsync(&C_d, M * N * sizeof(float), stream));

        //Load Test Cases
        CUDA_CHECK(cudaMemcpyAsync(A_d, A_h, M * K * sizeof(__nv_bfloat16), cudaMemcpyHostToDevice, stream));
        CUDA_CHECK(cudaMemcpyAsync(B_d, B_h, K * N * sizeof(__nv_bfloat16), cudaMemcpyHostToDevice, stream));

        // Initialize the result on the device
        CUDA_CHECK(cudaMemsetAsync(C_d, 0, M * N * sizeof(float), stream));

        //Check if the dimensions are divisible by the block tile dimensions
        assert(M % MMA_M == 0);
        assert(N % MMA_N == 0);
        assert(K % MMA_K == 0);

        dim3 gridDim((N + MMA_N - 1) / MMA_N, (M + MMA_M - 1) / MMA_M);
        dim3 blockDim(BLOCK_SIZE);  // one warp per block
        int shmemBytes = (MMA_M * MMA_K + MMA_K * MMA_N) * sizeof(__nv_bfloat16);

        // Launch kernel
        // Grid: ((N + MMA_N - 1/ MMA_N), (M + MMA_M - 1)/ MMA_M, 1)
        // Block: (256, 1, 1)
        void *args[] = {&A_d,
                        &B_d,
                        &C_d,
                        (void*)&M,
                        (void*)&N,
                        (void*)&K};

        CUDA_CHECK(cudaLaunchKernel((void*)k_mmaTensorMatMul,
                                    gridDim,
                                    blockDim,
                                    args,
                                    shmemBytes,
                                    stream));

        CUDA_CHECK(cudaStreamSynchronize(stream));

        cpuMatMulReference(A_h, B_h, cpuC_h, M, N, K);

        //Copying the result back to the host
        CUDA_CHECK(cudaMemcpyAsync(gpuC_h, C_d, M * N * sizeof(float), cudaMemcpyDeviceToHost, stream));

        //Validate the result, with in 1% tolerance
        for(int t = 0; t < M*N; ++t) {
            assert(std::fabs((gpuC_h[t] - cpuC_h[t]) / std::fabs(cpuC_h[t])) <= TOLERANCE);
        }

        //Free up resources
        CUDA_CHECK(cudaFreeAsync(A_d, stream));
        CUDA_CHECK(cudaFreeAsync(B_d, stream));
        CUDA_CHECK(cudaFreeAsync(C_d, stream));
        CUDA_CHECK(cudaStreamDestroy(stream));
        free(A_h);
        free(B_h);
        free(cpuC_h);
        free(gpuC_h);
    }
}

// Storing 16x8 Matrix Tile
__device__ __forceinline__ void d_storeMatrixTile16x8(__nv_bfloat16* dst, __nv_bfloat16* (&reg)[4], int dstStrideBytes) {
   int lane = threadIdx.x % 32;

    //Casting 2x bf16 elements into 4 byte space of uint32_t
    uint32_t (&regInt)[2] = reinterpret_cast<uint32_t(&)[2]>(reg);
    uint32_t* dstPtr = reinterpret_cast<uint32_t*>(dst);
    dstStrideBytes /= sizeof(uint32_t);

    int fragmentRow = lane / 4;
    int fragmentCol = lane % 4;

    // Adjacent Threads store 4 bytes each
    dstPtr[fragmentRow * dstStrideBytes + fragmentCol] = regInt[0];
    fragmentRow += 8;
    dstPtr[fragmentRow * dstStrideBytes + fragmentCol] = regInt[1];
}

__device__ __forceinline__ uint32_t d_cvtaToSharedU32(const void* ptr) {
    unsigned long long address;
    asm volatile("cvta.to.shared.u64 %0, %1;" : "=l"(address) : "l"(ptr));
    return static_cast<uint32_t>(address);
}

__device__ __forceinline__ void d_storeMatrixTile16x8_f32(float* dst, float reg[4], int n) {
    int lane = threadIdx.x % 32;  // 0..31
    int r = lane / 4;        // 0..7 for the top half
    int c = (lane % 4) * 2;    // columns: 0,2,4,6
    dst[r * n + c] = reg[0];
    dst[r * n + c + 1] = reg[1];
    dst[(r + 8) * n + c] = reg[2];
    dst[(r + 8) * n + c + 1] = reg[3];
}

__global__ void k_mmaTensorMatMul(__nv_bfloat16 *inputLayerA_d, __nv_bfloat16 *inputLayerB_d, float *outputLayer_d, int mDim, int nDim, int kDim) {

    // Tile indices.
    int blockM = blockIdx.y;
    int blockN = blockIdx.x;

    int aRow = blockM * MMA_M;  // starting row in inputLayerA_d
    int bCol = blockN * MMA_N;  // starting column in inputLayerB_d

    // Allocate shared memory for one tile of inputLayerA_d (16×8) and one tile of inputLayerB_d (8×8).
    extern __shared__ __nv_bfloat16 shmem[];
    __nv_bfloat16* aTile = shmem;                    // MMA_M * MMA_K elements
    __nv_bfloat16* bTile = shmem + MMA_M * MMA_K;    // MMA_K * MMA_N elements

    // Each thread holds a fragment of the output: 4 f32 values.
    float accReg[4] = {0.0f, 0.0f, 0.0f, 0.0f};

    int numTilesK = kDim / MMA_K;

    for (int tileK = 0; tileK < numTilesK; tileK++) {
        // Global pointers for the current tile.
        __nv_bfloat16* aG = inputLayerA_d + aRow * kDim + tileK * MMA_K;
        __nv_bfloat16* bG = inputLayerB_d + (tileK * MMA_K) * nDim + bCol;

        // Load inputLayerA_d tile (16×8) into shared memory with bounds checking.
        for (int i = threadIdx.x; i < MMA_M * MMA_K; i += blockDim.x) {
            int r = i / MMA_K;
            int c = i % MMA_K;
            int global_r = aRow + r;
            int global_c = tileK * MMA_K + c;
            aTile[i] = (global_r < mDim && global_c < kDim) ? aG[r * kDim + c] : __nv_bfloat16(0.0f);
        }

        // Load inputLayerB_d tile (8×8) into shared memory with bounds checking.
        for (int i = threadIdx.x; i < MMA_K * MMA_N; i += blockDim.x) {
            int r = i / MMA_N;
            int c = i % MMA_N;
            int global_r = tileK * MMA_K + r;
            int global_c = bCol + c;
            bTile[i] = (global_r < kDim && global_c < nDim) ? bG[r * nDim + c] : __nv_bfloat16(0.0f);
        }
        __syncthreads();

        // Load fragments from shared memory using ldmatrix.
        uint32_t aRegTile[2];
        int lane = threadIdx.x;
        int aTileByteOffset = d_cvtaToSharedU32(aTile) + ((lane % MMA_M) * MMA_K * sizeof(__nv_bfloat16));
        unsigned long long aTileByteOffset64 = static_cast<unsigned long long>(aTileByteOffset);
        asm volatile("ldmatrix.sync.aligned.m8n8.x2.shared.b16 {%0, %1}, [%2];"
                     : "=r"(aRegTile[0]), "=r"(aRegTile[1])
                     : "l"(aTileByteOffset64));

        uint32_t bRegTile;
        int bTileByteOffset = d_cvtaToSharedU32(bTile) + ((lane % MMA_K) * MMA_N * sizeof(__nv_bfloat16));
        unsigned long long bTileByteOffset64 = static_cast<unsigned long long>(bTileByteOffset);
        asm volatile("ldmatrix.sync.aligned.m8n8.x1.trans.shared.b16 {%0}, [%1];"
                     : "=r"(bRegTile)
                     : "l"(bTileByteOffset64));

        // Perform MMA: multiply the bf16 fragments and accumulate into f32 registers.
        asm volatile("mma.sync.aligned.m16n8k8.row.col.f32.bf16.bf16.f32 "
                     "{%0, %1, %2, %3}, {%4, %5}, {%6}, {%0, %1, %2, %3};"
                     : "+f"(accReg[0]), "+f"(accReg[1]), "+f"(accReg[2]), "+f"(accReg[3])
                     : "r"(aRegTile[0]), "r"(aRegTile[1]), "r"(bRegTile));
        __syncthreads();
    }

    // Write the computed output tile (16×8) to global memory.
    float* cTile = outputLayer_d + aRow * nDim + bCol;
    d_storeMatrixTile16x8_f32(cTile, accReg, nDim);
    __syncthreads();
}

void runner();

int main() {
   runner();
   return 0;
}
