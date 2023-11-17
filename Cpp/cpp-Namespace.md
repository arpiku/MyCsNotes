```cpp
// What are namespaces and why do we need them
// Name spaces are a way to differentiate between functions, variables or classes with the same name
// one might wonder why that is required when function overloading exists in C++
// this is because aside from function variables and classes may have same name as using different names for each 
// variable or object that may be similar in functionality is can make code confusing
// also functions may be taking similar data type parameters but are doing performing different operation(example below
// also it is possible that code base that you are working with or may be even in STL there may be functions with names that you
// would want to use, this helps to give unique identification in such cases
// now C doesn't have namespaces, so one has to specify specifically the full name of the function 


// so basically they provide you a way of giving a unique name to some function with same signature
#include<iostream>
#include<string>
namespace first
{
	void print(const char* message)
	{
		std::cout << message << std::endl;
	}
}

namespace second
{
	void print(std::string& message) 
	{
		std::cout << message << std::endl;
	}
}

using namespace first;

using std::cout; // Now we don't need to write 'std::' before using 'cout' and  'cin'
using std::cin; // '::' this is called scope resolution operator

int main()
{
	namespace a = second;
	print("Hello");
	std::string Text;
	Text = "String";
	second::print(Text);
	//second::print("Hello Again"); // This won't work when using reference as more than one type conversion have to be perfomed
									// remove the '&' to from print function and comment out the 2nd line above
	//a::print("Hello once again");

	cout << " This works " << endl;

	std::cin.get();

}

```