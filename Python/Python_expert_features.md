https://www.youtube.com/watch?v=mclfteWlT2Q&list=PLzMcBGfZo4-kwmIcMDdXSuy_wSqtU-xDP

# Python
1. Since python code runs live and is executed on the fly, all of the defined things have some memory allocated to them.
2. Everything is an object! 
~~~python 
def show():

	print('a')

def show():

	print('b')

def show():
	
	print('c')

for i in range(10):

	def show2():

		print(i*2)

	show2()

show()

#function pointers are handled ratehr easily in python
new_func = func(x)
new_func() #and this will call the func(x), isn't this amazing
print(id(new_func())) #will give out the memory address of the function.


def show():

	print('a')

def show():

	print('b')

def show():

	print('c')

  

for i in range(10):

	def show2():

		print(i*2)

show2()

  

show()

  
  

print(id(show())) #Both of these give the same memory address, how is that possible

print(id(show2()))
~~~

~~~python
import inspect # This thing can be used to inspect the source code of the object being inspected.
import numpy
print(inspect.getsource(numpy)) # Will print out the source code to the terminal
~~~

~~~python
x = [22,11,23]
y = [21,54,65]

