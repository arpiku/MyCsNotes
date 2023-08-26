# lists:
Lists are mutable objects and can grow and contract dynamically. They can also contain heterogeneous items.
```python
a.append(obj) # to append at the end
a.insert(index,obj) # to insert it with a given position in the correct position automatically
a.insert(0,34)
del a[4] # will delete the fourth element

#there is direct search implemented.

# set() operation can remove the duplicate objects from the list.

b = list(set(a+b))

# to sort 
b.sort()

# to reverse
b.reverse()
trees=trees[::-1] # you can also do this.

#also 
trees = trees[:-1] # this is to remove the last element

# all sort of string based operations can also be perfomed using lists

string_list = ['a','b','c','d']
dd = ','.join(string_list)

len(a) # for the length of a list
```

# Strings:
```python
# there are direct functions that can be implemented on the strings
# mystring is read from a file, which contains the text "Hello World"
#
myindex=mystring.find("World")

# find and replace

m_new_string = my_string.replace('a', 'b')

```

### a program to check for palindrome
```python
a = "aaabaaa"
return(a == a[::-1])
```

# tuples:
1. The idea is that since they are immutable, they are meant to represent read only data.
2. Also this is possible
```python
# they are more like immutable lists than anything, they can store hetrogenous values.

# the idea is that since they are immut
my_tuple = (1,"a")
		my_dict = {my_tuple : 1}
		
```
# Dictionaries:
A dictionary is a data structure in Python similar to a hash-map in other languages. A dictionary maps a key to a value like a real dictionary maps a word to its meaning.

```python
#adding entries
tree_type['new_key'] = ['new_value']
# and entries can be deleted just as easily

del tree_type['new_key']
# to get all the keys
keys = tree_types.keys
#similarly
values = tree_types.values

```
### Function variable scope
1. In python variables declared inside the function have local scope and lifetime, i.e the variable created inside the function is deleted once the function exists.


# Generotors and Yields