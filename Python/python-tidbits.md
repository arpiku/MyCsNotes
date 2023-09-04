```python
  1 import os
  2
  3 names = ["list", "forward-list", "set", "multiset", "map", "multimap", "unordered_map", "unordered_multimap", "unordered_set", "unordered_multiset", "stack", "queue", "priority_queue", "falt_set",
  4 "flat_multiset", "flat_map", "flat_multimap", "span", "mdspan"]
  5
  6 curr_dir = os.getcwd();
  7
  8 for name in names:
  9         file_path = os.path.join(curr_dir,str("cpp-"+name+".md"))
 10         try:
 11                 with open(file_path, "w"):
 12                         pass
 13                 print(f"created file: {name}")
 14         except Exception as e:
 15                 print(e)                print(e)                print(e)
```
- The above code creates the files provided in the list in the working directory.