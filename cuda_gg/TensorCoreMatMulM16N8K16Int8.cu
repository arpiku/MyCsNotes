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
#define MMA_K 16

__global__ void k_mmaTensorMatMulM16N8k16Int8(uint8_t *inputMatrixA_d, uint8_t *inputMatrixB_d, int *outputMatrix_d, int mDim, int nDim, int kDim);

// Function to compute valid reference result

void cpuMatMulReference(const uint8_t* A,
                        const uint8_t* B,
                        int* cpuRefC,
                        int M,
                        int N,
                        int K) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            int sum = 0;
            for (int k = 0; k < K; k++) {
                int a_val = static_cast<int>(A[i * K + k]);
                int b_val = static_cast<int>(B[k * N + j]);
                sum += a_val * b_val;
            }
            cpuRefC[i * N + j] = sum;
        }
    }
}

void runner() {
    const int TEST_CASE_COUNT = 7;
    //Test case dimensions {M, N, K}
    const int TEST_CASES_DIMS[TEST_CASE_COUNT][3] = {{16,8,16}, {512,512,512}, {32,16,32}, {256, 256, 256}, {64, 64, 64} , {64, 32, 32}, {128, 128, 128}};

    const int BLOCK_SIZE = 256;

    //Set up random number generation
    std::random_device randomSeedSource; // Automatically configure high quality seed using system info
    std::mt19937 randEngine(randomSeedSource());

    // Bounded random distribution for test case initialization
    std::uniform_real_distribution<float> randDist(1.0f, 255.0f);

    for (int i = 0; i < TEST_CASE_COUNT; i++) {
        // Dimensions of the input and output layers
        int M = TEST_CASES_DIMS[i][0]; //Number of Rows in Matrix A
        int N = TEST_CASES_DIMS[i][1]; //Number of Columns in Matrix B
        int K = TEST_CASES_DIMS[i][2]; //Number of Columns in Matrix A and Rows in Matrix B

        //Pointers for Host Memory
        uint8_t* A_h =(uint8_t*)malloc(M * K * sizeof(uint8_t));
        uint8_t* B_h =(uint8_t*)malloc(K * N * sizeof(uint8_t));

        int* cpuC_h =(int*)malloc(M * N * sizeof(int)); // Reference Matrix space allocation on host
        int* gpuC_h = (int*)malloc(M * N * sizeof(int));// GPU result Matrix space allocation on host

        //Pointers for device memory (GPU)
        uint8_t* A_d;
        uint8_t* B_d;
        int* C_d;

        //Populating input matrices with random values
        for (int i = 0; i < M * K; i++) {
            uint32_t val = randDist(randEngine);
            A_h[i] = uint8_t(val);
        }

        for (int i = 0; i < K * N; i++) {
            uint32_t val = randDist(randEngine);
            B_h[i] = uint8_t(val);
        }

        // Use a CUDA stream for asynchronous operations
        cudaStream_t stream;
        CUDA_CHECK(cudaStreamCreate(&stream));

        // Allocate the memory on the device
        CUDA_CHECK(cudaMallocAsync(&A_d, M * K * sizeof(uint8_t), stream));
        CUDA_CHECK(cudaMallocAsync(&B_d, K * N * sizeof(uint8_t), stream));
        CUDA_CHECK(cudaMallocAsync(&C_d, M * N * sizeof(int), stream));

        //Load Test Cases
        CUDA_CHECK(cudaMemcpyAsync(A_d, A_h, M * K * sizeof(uint8_t), cudaMemcpyHostToDevice, stream));
        CUDA_CHECK(cudaMemcpyAsync(B_d, B_h, K * N * sizeof(uint8_t), cudaMemcpyHostToDevice, stream));

        // Initialize the result on the device
        CUDA_CHECK(cudaMemsetAsync(C_d, 0, M * N * sizeof(int), stream));

        //Check if the dimensions are divisible by the block tile dimensions
        assert(M % MMA_M == 0);
        assert(N % MMA_N == 0);
        assert(K % MMA_K == 0);

        dim3 gridDim((N + MMA_N - 1) / MMA_N, (M + MMA_M - 1) / MMA_M);
        dim3 blockDim(BLOCK_SIZE);
        int shmemBytes = (MMA_M * MMA_K + MMA_K * MMA_N) * sizeof(uint8_t);

        // Launch kernel
        // Grid: ((N + MMA_N - 1/ MMA_N), (M + MMA_M - 1)/ MMA_M, 1)
        // Block: (256, 1, 1)
        void *args[] = {&A_d,
                        &B_d,
                        &C_d,
                        (void*)&M,
                        (void*)&N,
                        (void*)&K};

        CUDA_CHECK(cudaLaunchKernel((void*)k_mmaTensorMatMulM16N8k16Int8,
                                    gridDim,
                                    blockDim,
                                    args,
                                    shmemBytes,
                                    stream));

        CUDA_CHECK(cudaStreamSynchronize(stream));

        cpuMatMulReference(A_h, B_h, cpuC_h, M, N, K);

        //Copying the result back to the host
        CUDA_CHECK(cudaMemcpyAsync(gpuC_h, C_d, M * N * sizeof(int), cudaMemcpyDeviceToHost, stream));

        //Validate the result
        for(int t = 0; t < M*N; ++t) {
            assert(gpuC_h[t] == cpuC_h[t]);
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

__device__ __forceinline__ void manual_load_fragment_A(const uint8_t* src, uint32_t frag[2], int stride) {
    uint32_t reg0 = uint32_t(src[0]) | (uint32_t(src[1]) << 8) | (uint32_t(src[2]) << 16) | (uint32_t(src[3]) << 24);
    uint32_t reg1 = uint32_t(src[8*stride]) | (uint32_t(src[8*stride + 1]) << 8) |
                    (uint32_t(src[8*stride + 2]) << 16) | (uint32_t(src[8*stride + 3]) << 24);
    frag[0] = reg0;
    frag[1] = reg1;
}

__device__ __forceinline__ uint32_t manual_load_fragment_B(const uint8_t* src) {
    int lane = threadIdx.x % 32;
    uint8_t v0 = src[0 + lane/4];
    uint8_t v1 = src[8 + lane/4];
    uint8_t v2 = src[16 + lane/4];
    uint8_t v3 = src[24 + lane/4];
    uint32_t frag = (uint32_t)v0 | ((uint32_t)v1 << 8) | ((uint32_t)v2 << 16) | ((uint32_t)v3 << 24);
    return frag;
}

// Kernel: Multiply uint8_t matrices inputMatrixA_d (mDimx kDim) and inputMatrixB_d (kDim x nDim) to produce an output outputMatrix_d (mDim x nDim) in f32.
// Each block (a single warp) computes one 16×8 output tile using MMA instructions.
__global__ void k_mmaTensorMatMulM16N8k16Int8(uint8_t *inputMatrixA_d,
                                              uint8_t *inputMatrixB_d,
                                              int *outputMatrix_d,
                                              int mDim,
                                              int nDim,
                                              int kDim) {
    // Tile indices.
    int blockM = blockIdx.y;
    int blockN = blockIdx.x;
    int aRow = blockM * MMA_M; // starting row for this tile in A
    int bCol = blockN * MMA_N; // starting column for this tile in B

    int lane = threadIdx.x % 32;

    // Shared memory:
    // aTile holds the A tile (16x16)
    // bTile holds the B tile (16x8)
    extern __shared__ __align__(16) uint8_t shmem[];
    uint8_t* aTile = shmem;
    uint8_t* bTile = shmem + (MMA_M * MMA_K);

    // Accumulator for MMA (s32) initialized to zero.
    int accReg[4] = {0, 0, 0, 0};

    int numTilesK = kDim / MMA_K;
    for (int tileK = 0; tileK < numTilesK; tileK++) {
        uint8_t* aG = inputMatrixA_d + aRow * kDim + tileK * MMA_K;
        uint8_t* bG = inputMatrixB_d + (tileK * MMA_K) * nDim + bCol;

        // Load A tile into shared memory.
        for (int i = threadIdx.x; i < MMA_M * MMA_K; i += blockDim.x) {
            int r = i / MMA_K;
            int c = i % MMA_K;
            int global_r = aRow + r;
            int global_c = tileK * MMA_K + c;
            aTile[i] = (global_r < mDim && global_c < kDim) ? aG[r * kDim + c] : 0;
        }
        // Load B tile into shared memory
        for (int i = threadIdx.x; i < MMA_K * MMA_N; i += blockDim.x) {
            int r = i / MMA_N;
            int c = i % MMA_N;
            int global_r = tileK * MMA_K + r;
            int global_c = bCol + c;
            bTile[i] = (global_r < kDim && global_c < nDim) ? bG[r * nDim + c] : 0;
        }
        __syncthreads();

        // Load Fragments into registers
        uint32_t fragA[2];
        int offsetA = (lane / 4) * 16 + (lane % 4) * 4;
        manual_load_fragment_A(&aTile[offsetA], fragA, MMA_K);

        int offsetB = 32 * (lane % 4);
        uint32_t fragB = manual_load_fragment_B(&bTile[offsetB]);

        // Perform MMA accumulate.
       asm volatile("mma.sync.aligned.m16n8k16.row.col.s32.u8.u8.s32.satfinite "
                     "{%0,%1,%2,%3}, {%4,%5}, {%6}, {%0,%1,%2,%3};"
                     : "+r"(accReg[0]), "+r"(accReg[1]), "+r"(accReg[2]), "+r"(accReg[3])
                     : "r"(fragA[0]), "r"(fragA[1]), "r"(fragB));

        __syncthreads();
    }

    // Write the computed 16x8 output tile (from the accumulator) to global memory.
    int* cTile = outputMatrix_d + aRow * nDim + bCol;

    int block_row = lane / 4;  // 0..7
    int block_col = lane % 4;  // 0..3

    int row_out = block_row * 1;
    int col_out = block_col * 2;


    cTile[row_out * nDim + col_out] = accReg[0];
    cTile[row_out * nDim + col_out + 1] = accReg[1];
    cTile[(row_out + 8) * nDim + col_out] = accReg[2];
    cTile[(row_out + 8) * nDim + col_out + 1] = accReg[3];
    __syncthreads();
}

void runner();
int main() {
   runner();
   return 0;
}
