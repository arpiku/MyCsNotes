# numpy tutorial

## Introduction
1. Core of a lot of other libraries like pandas, sckit-learn , matplotlib.
2. Provides datatypes to create, handle and operate on n-dimensional arrays.
3. High perfomance for large array sizes.
4. A lot of code is actually written in C.

### Use cases
1. Linear algebra.
2. Matrix operations, inverse, determinant, 
3. To model linear systems
4. Eigenvectors.
5. Random numbers
6. Images as nd arrays.

~~~python
import numpy as np
print(np.__version__)

a = np.array([1,3,4])
print(a.shape)
print(a.dtype)
print(a.ndim) # number of dimensions
print(a.size) # total number of elements
print(a.itemsize) #size of elements in bytes

print(a[0]) 
a[0] = 20

b = a*np.array([3,4,5]) #this is great!

l = [1,2,3] #this is a list
k = np.array([1,2,3,4]) # this is an array

#They look the same but are not.

l.append(4) # this works
l = l + [1] # this works too lol

#np arrays do not have the append functionality

a = a + np.array([4]) #This will work, but this will add 4 to all the elements.

#Similarly 

a = 5*a # This will multiply each element by 5.. however in lists we will get a list back with all items duplicated 5 times.


a = np.sqrt(a) 



# lists can directly be converted to array like this

a = np.array(l) 
a2 = np.array(l)

# dot product 
#important one
dot = np.dot(a1,a2) 
print(dot)

sum1 = a1*a2
dot = np.sum(sum1) 
print(dot)


dot = np.array(a1*a2).sum()
print(dot)


#important one
dot = a1@a2 
print(dot)

~~~


[[python_time]]
~~~python
import numpy as np
from timeit import default_timer as timer

a = np.random.randn(1000)
b = np.random.randn(1000)

A = list(a)
B = list(b)

T = 1000

def dot1():
	dot = 0
	for i in range(len(A)):
		dot += A[i]*B[i]
	return dot
def dot2():
	return np.dot(a,b)
start = timer()
	for t in range(T):
		dot1()
	end = timer()
	t1 = end-start

start = timer() 
	for t in range(T):
		dot2()
	end = timer()
	t2 = end - start
	
~~~
About ~138 times faster than lists

Multidimensional array
~~~python
#decleration is rather simple

a = np.array([[1,2,4],[3,2,11]])

#elements can be accessed in the following ways
print(a.shape)

c = a[0,0] # or a[0][0]
b = a[:,0]
d = a[0,:] #slicing

a = a.T # transposes the array

arr = np.array([[1,2],[3,4]])

inv = np.linalg.inv(arr) #array need to square for this to happen
det = np.linalg.det(arr) 
diag = np.diag(arr) # it can also be used to diagonlize 1D array

#say a1D is an arry of one dimension then

arrDiag = np.diag(a1D) # will return a matrix, diag elements top left to bottom right

#slicing

b = a[0,1:3] #this is slicing

# We can use negative numbers for indexing!!!!
b = a[-1,-1] # will return bottom right of the matrix

#boolean indexing

bool_idx = arr > 2
print(bool_idx)
print(arr[bool_idx])
#the above is same as
print(arr[a>2])

b = a.where(a>2, a,-1)

#fancy indexing; passing an array as index list for anther array

a = np.array([10,14,24,22,31,48])
even = np.argwhere(a%2 == 0).flatten()
print(even)

arr = np.arange(1,7) #create 1D array with numbers 1-6
b = arr.reshape(2,3) #new shape parameters

#creating new axis
~~~


# numpy from documentation
np.(array, dtype = datatype) this can be used to explicitly specify the array datatype.

`np.array()`, `np.zeros()`, `np.ones()`, `np.empty()`, `np.arange()`, `np.linspace()`, `dtype`

The default datatype can be define, empty arrays ([]) can be defined using the above function, they look like common non-array based elements but still belong to np array class object..

np has a direct sort function
~~~python

np.ones(2, dtype=np.int64).
np.ones([], dtype=np.int64). #ouput = 1

np.sort(arr) #numpy has more unique sorting capabilities too, like sorting particular row or column etc.


np.concatenate((x,y), axis=(None|1|0))

np.reshape(a, newshape=(1, 6), order='C') #this 'C' this is interesting

#'C' is for C like indexing, 'F' is fortran like indexing


~~~

# GNN Math:
1. $$  z_j^{(l+1)} = \sigma_{agg}\left[\mathrm{agg}\left(
        \sum_{j\in\mathcal{N}_1}\frac{1}{c_{ij}}W_1h_j, \ldots,
        \sum_{j\in\mathcal{N}_R}\frac{1}{c_{ij}}W_Rh_j
        \right)\right]
$$
2. $$  h_j^{(l+1)} = \sigma_{out}W_oz_j^{(l+1)} $$
3.  Bileaner decoder
4. $$   p(M_{ij}=r) = \text{softmax}(u_i^TQ_rv_j) $$
5. $$ Q_r = \sum_{s=1}^{b} a_{rs}P_s$$
6. 