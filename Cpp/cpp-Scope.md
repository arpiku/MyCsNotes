```cpp
#include<iostream>

int* CreateArray()
{
	//int array[50];
	int* array = new int[50]; // will work unlike the above statement
	return array; // Stupid doesn't work as the object will just get destroyed
	// as soon as it gets out of the scope
}

void ModifyArray(int* array)
{
	// DO something to array
}

// So how to implement it

class Entity
{
private:
	int m_ptr;
public:
	Entity(const Entity* member)
		:m_ptr(member)
	{}

	~Entity() 
	{
		std::cout << "destroyed" << std::endl;
	}

};

class Scopedptr
{
private:
	Entity* m_ptr;
public:
	Scopedptr(Entity* ptr)
		:m_ptr(ptr)
	{
	}

    ~Scopedptr()
	{
		delete m_ptr;
	}
};

int main()
{
	Entity* e = new Entity();
	{
		Scopedptr e2 = new Entity();
	}

	std::cin.get();

}

// Every time we enter a scope we put a stack frame on it, one the scope ends all the object
// in the stack get destroyed
// The memory does get deleted ones the program terminates

// example of use
// automatic timer for benchmarking
// stop multiple functions from entering same thread
```