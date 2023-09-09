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

## python-map
```python
# d = (lambda s:s[::-1])("I am a string")
# print(d)

# reverse = (lambda s:s[::-1])
# ##lambdas can return tuples,

# d = (lambda x : (x,x**2, x**3))(3)
# print(d)
: 
# """A lambda expression has its own local namespace, so the parameter names don’t conflict with identical names in the global namespace. A lambda expression can access variables in the global namespace, but it can’t modify them."""

# ##using map to apply a function to many values

# animals = ["cat", "dog", "hedgehog", "gecko"]
nums = [i for i in range(10)]
target = 10

data = ((i,j) for i in range(10) for j in range(10) if (i+j == 10 and i != j))
res = ((i,j) for i in nums for j in nums if (i+j == target and i!=j))

print(list(next(res)))


##some cool stuff

numbers = [1, 2, 3, 4, 5, ...]  # Example list of numbers
print(numbers)

def f(a, b, c):
    return a + b + c


list(map(f, [1, 2, 3], [10, 20, 30], [100, 200, 300]))
```