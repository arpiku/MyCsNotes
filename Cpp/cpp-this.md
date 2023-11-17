```cpp
// the this keyword is only accessible through a member function
// it is a pointer to the intantiated object inside of which it is invoked

#include<iostream>
#include<string>

void PrintEntity(Entity* e);

class Entity
{
public:
	int x, y;
	Entity(int x, int y) // valid for non-static method
	{
		// x=x; won't work
		// Entity* const e = thisMan; or Entity* e = thisMan;

		//e->x = x;

		this->x = x;
		(*this).y = y;
		PrintEntity(this); // to take it const ref. , derefrence the parameter and
		// apply const keyword in the function defination
	

		// delete this; // Not good 

	

	
	int GetX() const
	{
		// in a const function the defination with the const is applied
		const Entity* e = this;
		Entity* const e = this;
		//makes the e const and cannot be assigned new value
		// hence
		// This is wrong as we are in main function
		e->x = 5; // Not allowed

		Entity& e = *this;

		return x;
		
	}

	PrintEntity(this);
	PrintEntity2(*this);

	delete this; // Not good 
}

	void PrintEntity(const Entity& e);

void PrintEntity(Entity* e)
{
	// do something
}
```

```cpp
//Stack and Scope
// The scope is basically a stack frame, its like adding to stack of book
//all the data is in the books, ones you take out the book the data is gone

#include<iostream>
#include<string>

class Entity
{
public:
	Entity()
	{
		std::cout << "Destroyed Entity" << std::endl;
    }


};

int main()
{
	{

	}

	std::cin.get()
}

```