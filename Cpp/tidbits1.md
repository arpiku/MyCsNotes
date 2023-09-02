- #sorting #array #backtracking [[backTracking]][[array]][[stateSpaceTree]]
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