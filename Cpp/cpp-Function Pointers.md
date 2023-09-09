```cpp
// C style of doing function pointers
// Usually we call functions, its just a symbol that does something when called using someparameters
// and may return something

//however we can assign functions to variables and pass them to other function 

#include<iostream>

void Hello() {
	std::cout << "Hello World" << std::endl;
}

void HelloInt(int a)
{
	std::cout << "HEllO" << a << std::endl;
}
int main()
{
	auto example = Hello; // this actually gives you the memory address of that function
	auto example2 = &Hello; //Same as above(implicit conversion)
	// auto = Hello(); // won't work as we are calling the function in this statement

	std::cout << sizeof(example) << std::endl;

	//  basically your compiled functions are just set of cpu instruction, learn more about assembly language and cpu 
	// processing to get much clearer idea of what that means

	example();
	example2(); // The actual datatype here is void(*__VariableName__)(); 

	// because the statement below looks confusing
	void(*NewVar) = Hello;

	NewVar; // People tend to use auto
	//but we can use 'typedef' to create sort of our own variable as follows

	typedef void(*NameOfmyVar)();

	NameOfmyVar function = Hello;
	function();

	typedef void(*NameOfmyVarforInt)(int);
	NameOfmyVarforInt functionWithInt = HelloInt;
	functionWithInt(6);



	std::cin.get();

}
	
```