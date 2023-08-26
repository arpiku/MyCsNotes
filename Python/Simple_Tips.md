# Tips
## 1. Iterate using enumerate rather than range
~~~python
for idx,item in enumerate(items): # the enumerate returns a tuple of index and the item object.
	#do stuff 
for _, item in enumerate(items):
		#do stuff   # the _ is used to represent that the return value is not being used here.