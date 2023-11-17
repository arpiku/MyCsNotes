# Intro
(Notes from : Functional Programming in Python by David Mertz)
####  Functional Languages:
Lisp, Scheme, Clojure, Scala, Haskell, ML, OCAML, Erlang.

The characteristics of functional programming languages:
- Functions are the first class objects, i.e anything that can be done with data can be done with the functions, like passing it to another function.
- Recursion is the primary control structure, some languages do not even provide the 'loop' construct.
- There is a focus on list processing.
- "Pure" functional languages eschew side effects, this excludes the almost ubiquitous pattern in imperative languages, where the variables change to track the program state.
- Functional programming either discourages or completely disallows statement, rather relying on evaluation,
- Functional programming worries about what is to be computed rather than how it is to be computed.
- Higher order functions are important, that are functions working on functions working on functions.

## Understanding Monads:




### Avoiding Flow Control:
- Generally speaking languages employ loops and conditional branching statements, that mutate the data. The difficulty comes when one needs to find out the state of any given data during program runtime.
- This is simply solvable if the focus is not on 'how' rather than 'what to do with the data.
- So directly think in terms of 'here is the data', what needs to be done with it.
```python
collection = get_initial_stat()
state_var = None
for datum in data_set:
	if condition(state_var):
		state_var = cal_from(datum)
		new = modify(datum, state_var)
		collection.add_to(new)
	else:
		new = modify_differently(datum)
		collection.add_to(new)
for thing in collection:
	process(thing)
	
```
- **This just implies that modification and creation of data should be done in a funcitonal way, that is writing the data structure generating function, or wrapping the pipeline in a function.**
- For the above example just wrap the login in a function 'make_thing()', and call it for the datum in data.

### Comprehensions:
- Using comprehension is often a way to make the code more compact and shift the focus from 'how' to the 'what'.
- A *comprehension*  is an expression that uses the same keywords as loop and conditional blocks, but inverts their order to focus on the data rather than on the procedure.
- Simply changing the form of expression can often make a surprisingly large difference in how we reason about the code and how easy it is to understand.
- Python has multiple types of [python_comprehensions], generator comprehensions, set comprehensions, dict comprehensions.
- *Avoid nesting the comprehensions too much, as that will lead to the same issue as oop*.


### Generators:
- Generator comprehensions have the same syntax as list comprehensions, just replace the '[]' with '()'
- **They are lazy!**
- They are merely a description of 'how to get the data', that is not realized until one explicitly asks for it, either by calling .next() on the object, or by looping over it.
- This often saves memory and defers computation until it is actually required.
~~~python
log_lines = (line for line in read_line(huge_log_file) if complex_condition(line))
~~~

For typical uses, the behaviour is similar to the imperative implementation, but the runtime behaviour is nicer.

~~~python

def get_log_line(log_file):
	line = read_line(log_file)
	while True:
		try:
			if complex_condition(line)
				yield line
		except StopIteration:
			raise
log_lines = get_log_lines(huge_log_file)
~~~

- The above code is an example of 'how'.

```python
class GetLogLines(object):
	def __init__(self, log_file)
	self.log_file = log_file
	self.line = None

	def __iter__(self):
		return self
	def __next__(self):
		if self.line is None:
			self.line = read_line(log_file)
		while not complex_condition(self.line):
			self.line = read_line(self.log_file)
		return self.line

log_lines = GetLogLines(huge_log_file)
```

### Dicts and Sets:
- In the same fashion that lists can be created in comprehensions rather than by creating an empty list, looping, and repeatedly calling .append(), dictionaries and set can be created 'all at once' rather than by repeatedly calling .update() or .add() in a loop.
~~~python
{i:chr(65+i) for i in range(6)}
~~~
- The above will create a dictionary with the key being 'i' and and the value being 'chr(i+65)'.


### Recursion
- Functional programmers often put weight in expressing flow control through recursion rather than loops and branching statements.
- Done this way we can avoid altering the state of any variables or data structure within an algorithm, and more importantly get more at the 'what' than of 'how'.
- But this leads two different kind of recursions, one where is just a way to implement iteration, and the other where the problem can be divided into smaller and smaller problems each approachable in a similar manner.
~~~python

def factorialR(N):
	"Recursive factorial"
	assert isinstance(N, int) and N >=1
	return 1 if N <= 1 else N* factorialR(N-1)

def factorialI(N):
	"Iterative factorial function"
	assert isinstance(N, int) and N >=1
	product= 1
	while N>=1:
		product *= N
		N -= 1
	return product
~~~

- **Interesting**
~~~python
from functools import reduce
from operator import mul

def factorialHOF(n):
	return reduce(mul, range(1,n+1), 1)
~~~

- The 'recursion' approach is well suited for 'divide and conquer' problems as the complexity tends to be O(logN), so the depth isn't that much.
~~~python
def quicksort(lst):
	"Quicksort over a list-like sequence"
	if len(lst) == 0:
		return lst
	pivot = lst[0]
	pivots = [x for x in lst if x == pivot]
	small = quicksort([x for x in lst if x < pivot])
	large = quicksort([x for x in lst if x > pivot])
	return small + pivots + large
~~~

- As a general advice, use recursion when the problems looks dividable into smaller ones, other than that it is not great of an idea to use recursion just anther way to loop over something.

### Eliminating Recursion
- "Recursion without recursion", by using functools.reduct() or with *folding* operations, 
- **A recursion is often simply a way of combining something simpler with an accumulated intermediate result, and that is exactly what reduce does**

## Callables
- The emphasis in functional programming is, somewhat tautologously, on calling functions. 
- Python allows several ways to create functions, or at least something very-function like
	 - Regular 'def' functions
	 - lambda anonymous functions
	 - Instances of classes that define a __call()__ method.
	 - Closure returned by function factories.
	 - Static methods of instances, either via the @staticmethod decorator or via the class __dict__
	 - Generator functions.
- Technically the pure functions should not access the state of an instance at any level to determine their return value, but as python is an oop programming language, it is hard to implement the theoretical pure functions, the inner machinery of python prohibits creating something like @purefunction decorator that may do this.
- One need to understand that any useful program will generate an output in some form, the side-effects can be only contained to a certain degree, but not eliminated entirely.


### Named functions and Lambdas:
- Named functions and lambdas are pretty easy.
- The only difference between them is whether they have .__qualname__ attribute, since both can very well be bound to one or more names.

## Closures and Callable Instances:
- There is saying in computer science :  "Classes are data with operations attached and closures are operations with data attached." In practice the output is rather similar but the philosophical difference is worth considering, with classes emphasising mutable or rebind-able state, and closure emphasising immutability and pure functions.

~~~python
class Adder(object):
	def __init__(self,n):
		self.n = n
	def __call__(self, m):
		return self.n + m
add5_i = Adder(5)
~~~

~~~python
def make_adder(n):
	def adder(m):
		return m+n
	return adder
add5_f = make_adder(5)
~~~

- The behaviour completely is defined at the runtime, while the closure behaves more like a pure function, the behaviour of the conventional classes is different as it is sate dependent, running the code again in the same instance of the program, will result in a new number, as the data is stored in the class, and will add on the value that is already stored.
- One can explicitly make sure that the state cannot be changed, but this means that this information needs to be known by anyone who decides to inherit this function.

~~~python

adders = []
for n in range(5):
	adders.append(lambda m: m+n)

[adder(10) for adder in adders]
n = 10
[adder(10) for adder in adders]
~~~

~~~python
adders = []

for n in range(5):
	adders.append(lambda m, n=n: m+n)

[adder(10) for adder in adders]
[adder(10) for adder in adders]

~~~

- It is the second implementation that gives the desired result, using the 'compiler explorer', we can see that the value is unknown to the lambda, the lambda behaves like a pure function, unaware of the values that are not being passes to it, it will only operate on the last known value of 'n' not the current one, to correct it, it has to be passes to the lambda as above.

### Methods of Classes:

#### Accessor:
- Accessors, whether created with @property decorator or otherwise, are techanically callables, however with some limitations (from a FP point of view), in that they take no arguments as 'getters' and no return value as 'setters'.

~~~python

class Car(object):
	def __init__(self):
		self._speed = 100
	@property
	def speed(self):
		print("speed is", self._speed)

	@speed.setter
	def speed(self, value):
		print("setting to", value)
		self._speed_ = value

# car = Car()
# car.speed = 80
~~~
- In an accessor, we can co-opt the Python syntax for assignment and use to pass an arguement instead. Pretty easy in python syntax.
~~~python
	class TalkInt(int):
		def __lshift__(self, other):
		print("shift", self, "by", other)
		return int.__lshift__(self,other)
	t = TalkInt(8)
	t<<8
	Shift 8 by 3
	64
~~~

~~~python
#Just some fun stuff

x = lambda m:m*m

y = lambda g:x(x(g))
~~~

- The limited use in functional programming is due to the fact that they take no arguments as getters and return no value as setters.
- Every operator in python is a basically a function under the hood.


### Static Methods
- The way functional programming approaches classes is different, instead of classes being an encapsulation of the data and its related functions, it is more like a namespace for related functions.
~~~python

import math

class RightTriangle(object):
	"Class used soley as namespace for related functions"

	@staticmethod
	def hypotenuse(a,b):
		return math.sqrt(a**2 + b**2)

	@staticmethod
	def sin(a,b):
		return a/RighTriangle.hypotenuse(a,b)
	@staticmethod
	def cos(a,b)
		return b/RightTriangle.hypotenuse(a,b)
~~~

- This is important in order to avoid polluting the global (or module, etc) namespace, and this allows us to rename an instance to other names.

~~~python

RightTriangle.hypotenuse(3,4)
rt = RightTriangle()
~~~

### Generator Functions:
- These are special functions that return not a value, but an iterator, that produces a sequence of values, that can be called using next() function on it. 
- While like any python object there are ways to introduce statefulness, in a generator function, but in principle generators can be 'pure', as they are just a simple function that produces (potentially infinite) sequence of values rather than a single value.
- However generator function have a great deal of 'internal state', it is at the boundaries of call signature and return value that they act like a side-effect-free 'black box'. 
~~~python
def get_primes():

candidate = 2

found = []

while True:

if all(candidate % prime != 0 for prime in found):

# yield candidate

found.append(candidate)

candidate += 1

primes = get_primes()
next(primes), next(primes), next(primes)
(2,3,5)

for _, prime in zip(range(10), primes):
	print(prime, end = " ")
	
~~~

### Multiple Dispatch
- An interesting approach to handle multiple path of execution is called 'multiple dispatach' or 'multimethods'. This is just function overloading.
- The idea here is to declare multiple signatures for a single function and call the the actual computation that matches the types or properties of the calling arguments.

### Predicate-Based Dispatch
~~~python

@predicate(lambda x:x<0, lambda y:True)
def sign(x,y):
	print('x is negative; y is', y)
@predicate(lambda x: x==0, lambda y: True)
def sign(x,y):
	print('x is zero; y is ', y)
~~~

- One can see how the conditional branching can be incorporated in the function call signature, making the code easier to debug.



## Lazy Evaluation
- Pythons iterator protocol is pretty cool. This capability is only loosely connected to functional programming per se, since Python does not quite offer lazy data structures like haskell.
- However using the iterator protocols and the standard library of iteratables, accomplish much the same effect.
- Haskell is inherently lazily evaluated, we might define a list of all the prime numbers as follows:
~~~python
primes = sieve[2..]
	where sieve (p:xs) = p : sieve [x | <-xs, (x 'rem' p)/= 0]
~~~

- Haskell also uses deep recursion, that will not be discussed yet.
- 


