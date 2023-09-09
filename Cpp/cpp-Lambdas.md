```cpp
//Lambdas were introduced in C++11
/* Lamdas are something to create a sort of throw away functions, basically they provide and alternative for our function pointers,
now this file includes information only about 'lambda functions' but other than that they are used for many things such as
1.Lambda calculus
2.Lambda expressions
3.Lambda programming etc., also they are very important of 'functional programming'*/


/* At first they might not seem of much  use, as at first they seem like just another way to define a function, but as they have there defination within them they help to avoid boiler plate code that has to be written, also as they behave like 'function objects', this
term is used for objects that are made to perform some operations, hence they could be passed into functions just like function objects
if the function accepts them.*/

#include<iostream>
#include<vector>
#include<algorithm>

void foreach(const std::vector<int>& values, void(*func)(int)) 
{
	for (int value : values)
	{
		func(value);// This statement is automatically calling the lambda that is defined in the main.
	}
	// This is very useful when you want to give the program the control of when to call certain functions, just like function
	// pointer, hence whenever one used function pointers one could use a lambda
}

int find_element(const  std::vector<int>& values)
{
	for (auto v : values)
	{
		if (v > 3)
		return v;
	}

	return -1;

}

int main()
{
	std::vector<int> values = { 1,5,4,2,3 };
	std::cout << "Without using lambda :" << find_element(values) << std::endl;
	auto element = std::find_if(values.begin(), values.end(), [](int value) {return value > 3; });
	// the std::find_if is just in iterator that will go through elements of provided data set
	// as one can see the lambda is defined within the call of the the iterator
	std::cout << "With using lamda :" << *element << std::endl; // Now one can see that there was no need to define
	// a whole new function for this as the required task was carried out by lambda without and extra code

	auto lambda = [](int value) {std::cout << "Value: " << value << std::endl; };
	foreach(values, lambda);

	// there are different methods of passing the values to a lambda same as functions,
	// [=] will copy the variable available in scope
	// [&] will call by all the variables in scope
	// [] will only consider variables that are in lambda defination
	// [a,&b] will only copy or reference the variables that are specified
	int a = 4000;
	int b = 3000;


	auto example = [a, &b]{ b = b + 1; std::cout << a << ", " << b << std::endl; };
	
	example();

	std::cin.get();
	return 0;
}
```

```cpp
//A case on why not to use namespace std;
// whenever we are using the standard library

#include<iostream>

using namespace std; // This line can be used to just take out the 'std::' part from our code
// as mentioned above this is requried when we are accessing methods from the standard library
// to understand about what namespaces are checout 'Namespaces'

namespace first
{
	void print(const std::string& text)
	{
		std::cout << text << std::endl;
	}
}

namespace second
{
	void print(const char* text)
	{
		std::string temp = text;
		std::reverse(temp.begin(), temp.end());
		std::cout << text << std::endl;
	}
}

using namespace first;
using namespace second;

int main()
{
	std::cout << "HellO" << std::endl;
	print("Hello");
	print("HellO");
	std::cin.get();
}

// The things is that some times code is return such that the obects inside the standard library and the ones
// created by the writer of the code have same implementation, now this seems weird, but in actual code that can be easily found
// on github, you may come across a namespace that has a class 'vector', and without std::, it will be difficult to understand 
// to which namespace vector belongs to
// similar thing is true for some of the methods provided by standard library, the names of user defined function and the ones in
// the lib may similar writing style making it difficult to understand what belongs to what

// and obviously this is true for user defined namespaces too

// The above example showing the two functions belonging to different namespaces which will called if we use namespaces?

//IMPORTANT
// The sort of problems discussed can cause silent run time error, a nightmare to resolve
// and NEVER EVER use 'using namespaces' in header files

//Tips
// use them inside smaller scopes, not throughout the project
// don't use them when there are discpencies, and same name functions exist, or when you need some sort of distinction between objects
// belonging to different namespaces;
```