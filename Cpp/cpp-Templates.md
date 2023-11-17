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


### ChernoCpp
```cpp
//In java of C# there is similar things called generics, they are similar to macros in the manner that 
// they basically can write code for depending on a particular situation 
// this is an exteremly useful tool to make your code better, more dynamic, 
//they are sort of blueprint according to which a piece of code may get generated 


// the following is an example of function overloading

#include<iostream>
#include<string>

void printfunc(int a)
{
	std::cout << a << std::endl;
}

void printfunc(std::string text)
{
	std::cout << text << std::endl;
}

template<typename T>
void printfuncT(T value)
{
	std::cout << value << std::endl;
}

template<typename T2, int N> // Here 'class' is 'typename', it is not the usuall C++ class,hence using class instead of 
	// 'typename' may seem a little bit confusing, but they are same
	// also
class Array
{
	private:
		T2 Arr[N];
	public:
		int GetArrSize() const { return N; };

};

int main()
{
	printfunc(5); // the template gets the datatype by implicit conversion
	printfuncT<int>(5); // you can explicitly pass the datatype
	printfunc("Arpit"); // Now basically for every type of datatype you will have to overload the function, this can be avoided
	// using templates
	printfuncT(5);
	printfuncT("ChernoTutorials"); // Now basically using this, no more multiple function defination are required the program 
	// automatically detect the datatype and write the code based on that

	// If the template function is not invoked during the compilation time, i.e it is never called, that code will never get added
	// hence in Visual Studio no errors will be shown in the template code if it is not being invoked
	
	Array<int, 5> example;
	std::cout<< example.GetArrSize();

	

	std::cin.get();

	//Some companies just out write ban the use of templates, but using templates way too much, then it just complicates things
	// behind any use, it may become extremely complex, the code becomes almost unreadable
	// otherwise they are extremlely useful tool to make your code more versatile
}
```

```cpp
#include<iostream>
#include<iterator>
// iterators are used to point to the container memory locations 




template<typename T, typename T2>
void Times(T val, T2 val2) {
    std::cout << val*2 << std::endl;
    std::cout << val*val2 << std::endl;
}

template<typename T>
T Add(T val, T val2) {
    return val+val2;
}

template<typename T, typename U>
class Object {
    private:
        T m_T;
        U m_U;
    public:
        Object(T t,U u) {
            m_T = t;
            m_U = u;
        }
        void Print() {
            std::cout << "T" << m_T << std::endl;
            std::cout << "U" << m_U <<std::endl;
        }

        ~Object() {

        };
};





int main() {
    //Times(8979, 'A');
    //Times(12.21212f,54);
    //std::cout << Add(20,10);
    Object<int,float> O(5,234.4);
    O.Print();

    return 0;
}
```