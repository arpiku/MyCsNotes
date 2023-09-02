- How is vector different from `std::array`?
`std::vector` and `std::array` are both container classes in C++ that allow you to store collections of elements. However, they have some key differences in terms of their characteristics and use cases:

1. Size:
   - `std::vector`: Dynamic size container. You can add or remove elements, and its size can change during runtime. It's resizable and grows automatically when needed.
   - `std::array`: Fixed size container. Its size is determined at compile-time and cannot be changed after creation.

2. Memory Allocation:
   - `std::vector`: Uses dynamic memory allocation. It typically allocates more memory than needed to accommodate future growth efficiently.
   - `std::array`: Uses stack memory. The memory for the array is allocated on the stack, which is generally faster but limited in size.

3. Performance:
   - `std::vector`: Provides amortized constant time (`O(1)`) for adding or removing elements from the end of the container. Insertions or removals in the middle or beginning may be slower (`O(n)` where `n` is the number of elements to shift).
   - `std::array`: Offers constant time (`O(1)`) access to elements and may perform better in situations where the size is fixed and known at compile-time.

4. Usage:
   - `std::vector`: Suitable for situations where the size of the container is not known in advance or needs to change dynamically. It's often used when you need a dynamic array-like structure.
   - `std::array`: Appropriate when the size is fixed and known at compile-time. It provides better performance and safety guarantees for situations where you don't need to change the size.

Here's an example of how to use both `std::vector` and `std::array`:

```cpp
#include <iostream>
#include <vector>
#include <array>

int main() {
    // Using std::vector
    std::vector<int> dynamicArray;
    dynamicArray.push_back(1);
    dynamicArray.push_back(2);
    dynamicArray.push_back(3);

    // Using std::array
    std::array<int, 3> fixedArray = {1, 2, 3};

    std::cout << "Vector elements: ";
    for (int elem : dynamicArray) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;

    std::cout << "Array elements: ";
    for (int elem : fixedArray) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;

    return 0;
}
```

In this example, `std::vector` allows dynamic resizing as elements are added, while `std::array` has a fixed size determined at compile-time. The choice between them depends on your specific use case and whether you need dynamic resizing or a fixed-size container.

## Let us talk about cpp Vectors;
- `std::vector<bool.` has special optimizations built in.
-  #cpp23  `std::assign_range` feature:
```cpp
#include <algorithm>
#include <cassert>
#include <list>
#include <vector>

using namespace std;

int main() {
  const auto source = std::list{2, 7, 1};
  auto destination = std::vector{3, 1, 4};
#ifdef __cpp_lib_containers_ranges
  destination.assign_range(source);
#else
  destination.assign(source.cbegin(), source.cend());
#endif
  std::assert(std::ranges::equal(source, destination));
}
```
- **at** is similar to  **[]**  but with bound checks
```cpp
#include <iostream>
#include <vector>
 
int main()
{
    std::vector<int> data = { 1, 2, 4, 5, 5, 6 };
 
    // Set element 1
    data.at(1) = 88;
 
    // Read element 2
    std::cout << "Element at index 2 has value " << data.at(2) << '\n';
 
    std::cout << "data size = " << data.size() << '\n';
 
    try
    {
        // Set element 6
        data.at(6) = 666;
    }
    catch (std::out_of_range const& exc)
    {
        std::cout << exc.what() << '\n';
    }
 
    // Print final values
    std::cout << "data:";
    for (int elem : data)
        std::cout << " " << elem;
    std::cout << '\n';
}
```

## Easy way to copy a C type array into C++ vector
```cpp
#include <iostream>
#include <vector>

int main() {
  int cArray[] = {1, 2, 3, 4, 5};
  size_t size = sizeof(cArray) / sizeof(cArray[0]);

  // Create a std::vector that uses the C-style array without copying
  std::vector<int> vec(cArray, cArray + size);

  // Now, 'vec' contains the same elements as 'cArray' without copying
  for (int elem : vec) {
    std::cout << elem << " ";
  }
  std::cout << std::endl;

  return 0;
}
```

## Access
-  `at`, `[]`, `front`, `back` , `data`(pointer to beginning)
- empty, size, max_size, reserve, capacity, shrink_to_fit
- clear, insert, insert_range, emplace, erase, push_down,