### ChernoCpp


```cpp
#include<iostream>
#include<string>
#include<stdlib.h> // includes some c functions

int main()
{
	"Arpit"; // A string 
	const char name[6] = "Arpit";

	std::cout << strlen(name) << std::endl;

	char* name2 = "Kumar";  // Not the best way to go won't work anymore(cherncpp)
	name2[2] = 'a'; // Not valid behaviour, it might work sometime but not the way to go
	// because cpp standard doesn't definde what should be done in this case
	// this is known as undefined as behaviour, this is because what we are modifying a
	// pointer to string literal in memory and string literals are stored in rom 

	//use release mode to get simplified assembly code

	//one can see in the assembly output how the data is stored in const part of the 
	// memory

	// However if we define at as usual array everything will fine, also this is possible

	char* nameas = (char*)"asdf"; // by gcc

	const wchar_t* name3 = L"Cherno"; // L signifies that it is made up of wide characters
	const char16_t name4 = u"cherno";
	const char32_t name5 = U"cherno"; // for utf32

	//diff between whar and char16, it actually depends on compiler 2 on windows and 4
	// on linux

	const char* teest = u8"cherno";

	//solving are appending problem

	using namespace std::string_literals; //cpp 14

	std::wstring name0 = L"Cherno"s + L"hello";

	const char* example = R"(asf asdffd fdfd line4)"; // avoid escape characters
	// works exactly like this

	const char* ex = "Line1\n"
	"Line2\n"
	"Line3\n";

	char important[] = "test";
	important[2] = 'g'; // this works even though string literals are always stored
	// in const memory , how!!
	// the system copies the data into a new variable(important) and modifies it, we are 
	// earlier we were modifhing the pointer but now copying the data into our variable
	//and modifying and that works.

	std::cin.get();

}
```






```cpp
//Notes for string literals
//In general strings are group of characters, in general text representation is a massive
// proble (Tom Scott video), so how string works

#include<iostream>
#include<string>

//Remeber wchar (2 bytes)

//Learn text encoding

void PrintString(std::string string)
{
	// We are passing a copy of the object(class), hence again dynamically 
	//allocating memory, now that obviously consumes memory along with the fact that
	// string copy is not fast 

	std::cout << string << std::endl;
}

//correct way to do it

void PrintString2(const std::string& string)
{
	std::cout << string << std::endl;
}

int main()
{
	const char* name = "Arpit"; // C style of representation
	std::string sName = "Arpit"; // hover over the name :-)
	//we use const because generally strings are immutable
	//Don't need to delete as we didn't allocate on heap,
	// if we are not using const we can modify the string

	//at the end of the name there will be 00 which is null termination character,
	// this is how it decides the size of the string and end of .

	char name2[4] = { 'A','k','3','\0'}; // double quotes directly declare as char*, but not '
	//what will happen if try to print it now

	std::cout << name << std::endl;
	std::cout << name2 << std::endl; // weird output without termination, one can write 
	//just 0 at the end too without the ''

	//standard library has class called string, the actual name is basic string, but 
	// std::string is a result due to template specialization, with char is parameter

	std::cout << sName << std::endl;

	//if we don't include the string header file the cout output operator stream cannot 
	//handle the string input, this is the reason we need to include it even though
	// iostream can handle C style strings

	//Now sName is a proper class thats why we have functionalities as follows

	std::cout << sName.size();

	strlen(name); //strcpy()
	// now this will not work

	//std::string test = "Arpit" + "Kumar"; //you cannot add two const char* pointers

	std::string test2 = "Arpit";
	test2 += "kumar"; // The operator can handle this overload now we are adding into 
	// a string unlike before and hence follwoing will work too
	// std::string test2 = std::string("Arpit") + "Kumar";

	bool contains = test2.find("Arp") != std::string::npos; 
	//Implementation of .contains()
	std::cout << test2 << std::endl;


	std::cin.get();
}
```

```cpp
#include<iostream>
#include<map>
#include<cstdint>
#include<string>
#include<regex>

int main()
{
	//Token definations using regex
	std::regex regComment("(//.*)");
	//std::regex regComment("(label)");
	std::regex regLabel("([A-za-z0-9_]+:)");
	std::smatch Label;
	std::smatch Comment;


	bool HasComment = false;
	bool HasLabel = false;

	const char* CommentPrefix = "//";
	const char LabelSuffix = ':';
	const 

	std::string exp = "   ar97it:   MOV A,B //Comment";



	if(exp.find(CommentPrefix)) HasComment = true;
	if (exp.find(LabelSuffix)) HasLabel = true;

	if (std::regex_search(exp, Label, regLabel)) std::cout << Label[0] << std::endl;
	if (std::regex_search(exp, Comment, regComment)) std::cout << Comment.str(0) << std::endl;


	std::cout << HasComment << ", " << HasLabel << std::endl;
	std::cout << "End" << std::endl;
	std::cin.get();
	return 0;
}
```

```cpp
//Notes for string literals
//In general strings are group of characters, in general text representation is a massive
// proble (Tom Scott video), so how string works

#include<iostream>
#include<string>

//Remeber wchar (2 bytes)

//Learn text encoding

void PrintString(std::string string)
{
	// We are passing a copy of the object(class), hence again dynamically 
	//allocating memory, now that obviously consumes memory along with the fact that
	// string copy is not fast 

	std::cout << string << std::endl;
}

//correct way to do it

void PrintString2(const std::string& string)
{
	std::cout << string << std::endl;
}

int main()
{
	const char* name = "Arpit"; // C style of representation
	std::string sName = "Arpit"; // hover over the name :-)
	//we use const because generally strings are immutable
	//Don't need to delete as we didn't allocate on heap,
	// if we are not using const we can modify the string

	//at the end of the name there will be 00 which is null termination character,
	// this is how it decides the size of the string and end of .

	char name2[4] = { 'A','k','3','\0'}; // double quotes directly declare as char*, but not '
	//what will happen if try to print it now

	std::cout << name << std::endl;
	std::cout << name2 << std::endl; // weird output without termination, one can write 
	//just 0 at the end too without the ''

	//standard library has class called string, the actual name is basic string, but 
	// std::string is a result due to template specialization, with char is parameter

	std::cout << sName << std::endl;

	//if we don't include the string header file the cout output operator stream cannot 
	//handle the string input, this is the reason we need to include it even though
	// iostream can handle C style strings

	//Now sName is a proper class thats why we have functionalities as follows

	std::cout << sName.size();

	strlen(name); //strcpy()
	// now this will not work

	//std::string test = "Arpit" + "Kumar"; //you cannot add two const char* pointers

	std::string test2 = "Arpit";
	test2 += "kumar"; // The operator can handle this overload now we are adding into 
	// a string unlike before and hence follwoing will work too
	// std::string test2 = std::string("Arpit") + "Kumar";

	bool contains = test2.find("Arp") != std::string::npos; 
	//Implementation of .contains()



	std::cout << test2 << std::endl;






	

	std::cin.get();
}

```

