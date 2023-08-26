# dunder methods in python
1. Dunder or magic methods in Python are the methods having two prefix and suffix underscores in the method name. Dunder here means “Double Under (Underscores)”. These are commonly used for operator overloading. Few examples for magic methods are: __init__, __add__, __len__, __repr__ etc.
2. This is similar to constructors in Cpp, and the overload too is like overloading constructor function in Cpp.

## Dunder or magic methods:
1.  They allow to imulate some built in behaviours and also allow you to overload operators.


__repr__
1. Meant to be unambiguous definition of the object, used for debugging and logging, meant to be seen by other developers.

__str__ 
1. to be seen by the end user.

~~~python

def __repr__(self):
	return "Emp ('{}', '{}',{})".format(self.first, self.last. self.pay)

def __str__(self):
	return '{}-{}'.format(self.name, self.email)
def __init__(self,x,Y):
	self.x = x
	self.y = y # like a constructor
~~~

