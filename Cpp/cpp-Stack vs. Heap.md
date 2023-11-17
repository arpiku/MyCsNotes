```cpp
// When our program starts , our program gets devided into multiple segments througout the memory,
// now they are several but two important ones are HEAP and STACK
// Stack is reletavily small (usually about 2MB), they are all variables and objects whose size is already defined at 
// the compilation time
// Heap stores any objects that are declared at the rum time i.e 'new' keyword

#include<iostream>

#define LOG(X) std::cout << X << std::endl;

struct Vertex
{
	float x, y, z;

	Vertex()
		:x(5.0f),y(3.23f),z(23.3f) {}// MemberInitializaion 


	void PrintValues()
	{
		LOG(x)  // Checkout 'macros' to understand what is going on
		LOG(y)
		LOG(z)
	}

};
int main()
{
	int a = 5; // Stack allocation of normal variable

	Vertex test;

	test.PrintValues(); // Stack allocation of struct

	Vertex* test2 = new Vertex(); // the '()' are optional btw



	int* a2 = new int; // heap allocation

	LOG(a);
	LOG(a2);
	
	test.PrintValues();
	test2->PrintValues();


	delete test2; // ALWAYS remember to delete pointer or you will end up with memory leaks
	delete a2; 

	std::cin.get();
}

//Important Stuff

// Stack allocation is extemely fast, if one looks at memory of the code, the objects inside the stack are next to each other
// just like a 'stack', this makes accessing them much faster. The program already has the address about which it may move forward 
// or backward to get to the required data. And as the objects already exist the program does have to go to look for memory during 
// run time.

// This means that heap allocation is much slower
// the 'new' keyword just called the function called 'malloc', which looks in the 'free list' to get time amount of required block on 
// the memory, this process is quite slow, as malloc is a 'heavy' function, and if you ask for more memory than already allocated
// than that has huge perfomance penelty

// Stack allocation is just one cpu instruction (look assembly language)
//that is obviously not the case with heap allocation
// this means that stack allocation can help you to really help the speed of your program, maybe even store the whole stack on the 
// CPU mesh for super fast execution


```