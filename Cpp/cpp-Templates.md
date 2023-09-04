- #cppTemplates #templateMetaProgramming 
- So templates are abstract class for  classes themselves hence template **Meta** Programming.
## Understanding the need of templates.
- Templates tackle the age old of problem of passing different types into code that is written for specific types.
- This emphasis the [[polymorphism]] of C++.
- Following is the kind of code that would have to be written in the times of C:
```c
#include<stdlib.h>

void qsort(void *base, size_t nmemb, size_t size,
		   int (*compare) (const void *, const void *));

int cmp_dbl(const void* va, const void* vb) {
	double a = *((double const*) va);
	double b = *((double const*) vb);

	if(a<b) return -1;
	else if(a == b) return 0;
	else return 1;
}

void f() {
double dbl_data[4] = {3.23,1.235,4.3532,6.123};
qsort(&dbl_data[0], 4u, sizeof(double), &cmp_dbl);
}
```
- The above is an example of quicksort algorithm [[quickSort]] 
- The problem is with the reuse of code that sometimes fails with types changing.
## Some pointers
- The problem is with code reuse.
- In the 1970s, some languages began allowing algorithms to written in `type-to-be-specified-later` 
- Algorithms where then intantiated on demand using `type-argument`
- This approach came to be known as **generic programming.**
- #BjarneStourtrup
	>**Lift algorithms and data structures from concrete examples to their most general and abstract form**

## Function Templates
- Recepie for making functions.
```cpp
template<class T>
T const& min(T const& a, T const& b) {
return (a<b) ? a : b;
}

template<class T>
void swap(T& a, T& b);

template<class RandomIt, class Compare>
void sort(RandomIt first, RandomIt last, Compare comp);
```
- These prototypes specify are recepie to go from a set of template parametes to actual concrete code.

## Class Templates
- Similarly templates are also recepie for creating classes.
```cpp
template<class T, class Alloc = allocator<T>>
class vector
{...};
```

## Member function Templates #cpp11
- Their look up rules are different from function templates.

## Variable Templates
- #typeTraits [[Type Traits Cpp]] 


## Lambda Templates
- #cpp20 

## Understanding Compilation
- #compiles [[Compiler Design]] 
### Compilation:
 - The process of converting human-readable source code into binary object files
 - From a high-level perspective, there are four stages of compilation (LSSC):
	 - Lexical Analysis
	 - Syntax Analysis
	 - Semantic Analysis
	 - Code generation
- In C++, we typically generate one object file for each source file

# Linking 
- The process of combining object files and binary libraries to make a working program.
The standard calls the compilation process **translation**.
**Translation is defined in well defined states.**


# Entity
- The standard defines **Entity** being one the following things:


**There is not definition of type Aliases**