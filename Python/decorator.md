# Decorators
1. Change or modify the behaviour of the functions without changing the code.
2. Functions can be passed as objects in python like following:
~~~python

def f1(f):
	f()

def f():
	print('hellO')

f1(f) # this works

def f1(func):
	def wrapper
	print('start')
	func()
	print('end')

	return wrapper