# Some Basic Stuff:
https://www.youtube.com/watch?v=8zbXyd_tA9A
https://betterdatascience.com/python-single-vs-double-quotes/

~~~python
my_list = ["a", "b" "c"]
# b and c will get contaconated as there is no ','

condition = true
if condition:
	x,y = 1,0
else:
	x,y = None,None

#The above code is right but

x,y = (1,0) if condition else None,None
#this will assign the tuple "()", to x, rather than just the 1, 0 values, do it like this

x,y = (1,0) if condition else (None, None)

#so consistant use of paranthesis

## The tuple issue 
t = ('a', 'b', 'c') # this is right

# but 
t = ('abc') # this will not have a single element but the string will be split into three components, do it like this
t = ('abc',)

# difference between single and double quotes

ThisIsAString = "a'b" 
# One can use the keyword 'r' to make sure all the special character in a string are escaped, like this
ThisisAlsoAString = r'53434$#$#' # or use the '\', whenever

### More example


name = 'Bob'

# Natural language
print("It is easy to get confused with single and double quotes in Python.")

# String interpolation
print(f"{name} said there will be food.")

# No need to escape a character
print("We're going skiing this winter.")

# Quotation inside a string
print("My favorite quote from Die Hard is 'Welcome to the party, pal'")

# Also 

print('You can use "double quotes" like this.')
~~~
![[python_single_double.png]]

## Triple Quotes in Python
~~~python
print("""Triple quote string example 1""")
print('''Triple quote string example 2''')

print("""Here's a string I'll split into
mulitple 
lines.""")

print("""You can use 'single quotes' and "double quotes" inside!""")

~~~
**A primary use case for triple quotes are documentation strings (docstrings) for functions:**
```python
def sum_list(lst: list):
    """Iterates over every list element and sums them.
    
    Keyword arguments:
    lst -- the input sequence of numbers.
    """
    res = 0
    for num in lst:
        res += num
        
    return res
```

## assert statement  and list stuff
```python
condition
assert condition, "The message that will be printed if the assertion was not true"
# this code will only be executed after the assertion has been verified.
# DO NOT USE PARANTHESIS AROUND THE STATEMENT FOR ASSERTION STATEMENT

my_list = [1,2,3] 
my_list.append(4) # this returns None so does the 'sort', do don't assign the return value to anything
my_list.sort()

```