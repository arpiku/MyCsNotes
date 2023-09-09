```cpp
// Macros is quite a broad term and may have different defination depending on the context 
// but in this file we will be looking at preproccessor statements, when a filel is compiled a preproccessor pass occurs
// which statement starting with '#' gets evaluted before any of the things in 'main()' happens

// They can be used to write code that act as 'find and replace' function for the code of your program, this means that 
// based on some condition some code may or may not get included in you project, this is quite useful as it allows one 
// to work on a single piece of that can behave entirely differently depending on the conditions
// they are different than templates, but in the basic sense one could say that they get evaluated before templates

// but again just like overusing macros like templates is not a good idea, keep the code simple, but when required they can be
// extremely powerful


#include<iostream>

#define example std::cout << " Hello Macros" << std::endl; // Now the word 'example' = the whole statement on the right

#define example2(x) std::cout << x << std::endl;

#define example3 


#ifdef PR_DEBUG 0// How to add 'PR_DEBUG' or anyother such preproccessor defination to your compiler will have 
// different methods based on your coding setup, for Visual Studio the method is given below
#define prdebugging std::cout << "First Option" <<std::endl;
#else prdebugging std::cout << "Second Option" <<std::endl;
#endif
// Based on the condition , if PR_DEBUG is defined the first line will execute or if not the second
// here one can get an idea how to use it, maybe you are debugging the code and printing some stuff but when you actually publish
// the software you don't want your user to see those outputs.

// The statement has to one line so if the code is long use '\'

#define NewMacro void printvaluefunction() \
{\
std::cout<<"PrintValue"<<std::endl;\
}

NewMacro // It defined the above function


int main()
{
	example // even ';' is not required now
		example2(123) // you can give them parameters
		example2("arpit") // this works
		prdebugging // Due to the missing ';' you will get weird indentation as your ide will try to do the identation
		printvaluefunction();
	
	std::cin.get();

}

// Specifically for Visual Studio 
```