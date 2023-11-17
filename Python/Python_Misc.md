# Misc Stuff
1. dunder = "\_ \_" in python. [[dunder method]]

- In python :
~~~python
def __del__(self):
	print(f"{self.__class__.__name__}.__del__") 
#other del functions
# x = A()

def __delitem__(self) #del x[0]
def __delattr__(self) #del x.a
def __len__(self) # len(x)
def __str__(self) #str(x)
def __repr(self) #repr(x)


#but 

del x #does not call __del__ #So a lot of people don't like it.

#it is supposed to run before 
~~~

Every object in python has something called the **reference count** that refers to the number of variables that are refering to that object, so the 'del' keyword is just deleting the name 'x' not the acutal object itself. Now __del__ is supposed to run when the refernce count hits zero. That's why it can be called sometimes when the number of references is just one.  'del may never be called' = written in the documentation. 
E.g in a case of binary tree when the child has a refernce to the parent and the parnet has a reference to the child, even though the local variables storing these values might be deleted, the reference count will not hit zero, which is an issue, so del shouldn't be used.

Now in [[cpython]], __del__ is always called when reference count hits zero, but python does not gurantee it will happen.


### upgrading Python:
```bash
- [ ] 
```
