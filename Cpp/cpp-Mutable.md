```cpp
//first use is was discussed before, usually done for debugging purposes, most
//common use

// other use reletated to lambdas

#include<iostream>

int main()
{
	int x = 8;

	auto f = [=]() mutable // = passed by value, & = passed by reference
	{
		x++;
		std::cout << "Hello" << std::endl;
	};// like a trow away function

	//after this x will again be 8

	f();
}
```