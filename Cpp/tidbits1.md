- #sorting #array #backtracking [[backTracking]][[array]][[stateSpaceTree]] #tidbits 
```cpp#include <algorithm>
#include <iostream>
#include <stdio.h>
#include <vector>

auto print = [](auto const &remarks, const std::vector<int> &v) {
  std::cout << remarks;
  for (auto &i : v) {
    std::cout << i << ' ';
  }
  std::cout << '\n';
};

void permute(std::vector<std::vector<int>> &m, std::vector<int> &v, int l,
             int h) {
  if (l == h) {
    m.push_back(v);
    return;
  }
  for (int i = l; i <= h; i++) {
    std::swap(v[i], v[h]);
    permute(m, v, l + 1, h);
    std::swap(v[i], v[h]);
  }
  return;
}

int main() {
  std::vector<int> v = {0, 1, 2, 3, 4, 5, 6, 7};
  for (int i = 0; i <= v.size(); i++) {
    std::vector<std::vector<int>> combinations;
    std::vector<int> temp = {v.begin(), v.begin() + i};
    permute(combinations, temp, 0, temp.size() - 1);
    for (auto &v : combinations) {
      print("Arr:", v);
    }
  }

  return 0;
}
```
Followed by
```bash
./a.out > combi.txt
```
- Fun little code snippet to print all the possible arrangement of an integer and store them.

## Parallel Matrix Multiplication using OpenMP
- #parallelprogramming #codeSnippet #tidbits
```cpp
#include <iostream>
#include <vector>
#include <omp.h>

// Function to multiply two matrices in parallel
std::vector<std::vector<int>> parallelMatrixMultiply(const std::vector<std::vector<int>>& A,
                                                     const std::vector<std::vector<int>>& B) {
    int rows_A = A.size();
    int cols_A = A[0].size();
    int cols_B = B[0].size();

    std::vector<std::vector<int>> result(rows_A, std::vector<int>(cols_B, 0));

    #pragma omp parallel for
    for (int i = 0; i < rows_A; i++) {
        for (int j = 0; j < cols_B; j++) {
            for (int k = 0; k < cols_A; k++) {
                result[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    return result;
}

int main() {
    // Matrix sizes
    const int rows_A = 1000;
    const int cols_A = 1000;
    const int rows_B = 1000;
    const int cols_B = 1000;

    // Initialize matrices A and B with random values (for simplicity, omitted here)

    std::vector<std::vector<int>> A(rows_A, std::vector<int>(cols_A, 1));
    std::vector<std::vector<int>> B(rows_B, std::vector<int>(cols_B, 2));

    // Perform parallel matrix multiplication
    double start_time = omp_get_wtime();
    std::vector<std::vector<int>> result_parallel = parallelMatrixMultiply(A, B);
    double end_time = omp_get_wtime();

    std::cout << "Parallel Matrix Multiplication took " << end_time - start_time << " seconds." << std::endl;

    return 0;
}

```

## Giving Rest to threads
```cpp
#include <iostream>
#include <chrono>
#include <thread>
 
// "busy sleep" while suggesting that other threads run 
// for a small amount of time
void little_sleep(std::chrono::microseconds us)
{
    auto start = std::chrono::high_resolution_clock::now();
    auto end = start + us;
    do {
        std::this_thread::yield();
    } while (std::chrono::high_resolution_clock::now() < end);
}
 
int main()
{
    auto start = std::chrono::high_resolution_clock::now();
 
    little_sleep(std::chrono::microseconds(100));
 
    auto elapsed = std::chrono::high_resolution_clock::now() - start;
    std::cout << "waited for "
              << std::chrono::duration_cast<std::chrono::microseconds>(elapsed).count()
              << " microseconds\n";
}
```
- The above code basically tell the OS, that 'Hey! I am not doing anything, so if you want to go ahead till I get back'