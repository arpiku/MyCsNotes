# venv and environment variables
1. Most python projects have dependencie s i.e libraries that were written by someone else, overtime the code might be updated, or some of the libraries fail to work with other ones, this is an issue.
2. Libraries over time add or remove featues, this might lead to the code not working when one of the lib gets an update or loses a particular feature.
3. Virtual enviroment create these 'folders', these environments keep the lib structure constant, i.e the code used in that particular environment used by different libraries doesn't get updated.
4. This prevent your code from breaking when you do some updates, or add some libraries, or python decided to not-backward compatible update.


# Everything is an object!
1. Even when functions are created they are an object of the class 'function', this is true for everything in python.

## class methods

~~~python
  1 class **entity**:

  2         number = 0

  3         

  4         def **__init__**(self, name):

  5                 self.name = name

  6         @**classmethod**

  7         def **num_of_people**(cls):

  8                 return cls.num_of_people

  9                 

 10 

 11 p1 =entity("tim")

 12 **print**(entity.num_of_people())
~~~

In the above code the class method does not need an instance to be called, it can be called directly on the class and will be able to access class specific attributes.


## class variables
They can be called with just the class name and also with an instantiated class, they are not particular to the instantiated object.


~~~python 

class Object:
	c_property = []

    def normal_func(self, x):
	    sefl.property = x

	@classmethod
	def class_method(cls)
		return len(c_property)

	@staticmethod
    def static_method(n):
	    print("Bark")


~~~

The static methods do not need an instantiated object at all, the class method do not need an instantiation as they rely on **class variables**.
