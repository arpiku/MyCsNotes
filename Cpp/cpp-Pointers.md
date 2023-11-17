```cpp
#include<iostream>
#include<vector>

int main()
{
	int* a;
	int b = 5;
	a = &b;
	std::cout << a << " " << b << std::endl;

	int SomeArry[10] = { 1,2,4,34,434,34,32,34,52,525 };
	int* plocation6 = &SomeArry[6];
	int* plocation0 = &SomeArry[0];

	std::cout << "first " << (int)plocation6 << std::endl; // (int) doesn't work in linux
	std::cout << "sixth " << (int)plocation0 << std::endl;
	std::cout << "diff " << plocation6 - plocation0 << std::endl;

	for (int i = 0; i < 10; i++)
	{
		std::cout << SomeArry + i << " = " << *(SomeArry + i) << std::endl;
	}

	char SomeString[] = "Arpit";
	char* pSomeString = SomeString;

	std::cout << pSomeString << std::endl;

	std::cout << (int)pSomeString[0] << pSomeString[3] << std::endl;

	//Pointers of char usually mean you are referring a string and thats why you should
	// be careful as some function will behave differently depending on the input.

	struct sSomeObject
	{
		int x = 0xA3A2A1A0;
		int y = 0xB3B2B1B0;

		sSomeObject() {
			x = 45;
			y = 34;
		}

	};

	//Stack Allocation(Compile time) i.e known at compile time

	sSomeObject pSomeObject[10]; //f11 step in // f10 step over// s+f11 step out

	// Heapt allocation(Run Time) i.e not known

	sSomeObject* pSomeObject = new sSomeObject[10]; //just allocates memory not initiate
	// if you dont give value 'cd' is used by vs to fill the memory

	sSomeObject* pSomeObject2 = new sSomeObject[10]{ 0 }; // initialized elements to zero
	// When you request memory always clean up after yourself

	delete[] pSomeObject; // Very Important
	delete[] pSomeObject2;

	// Somethings interesting

	sSomeObject **pSomeObject = new sSomeObject[10](); // pointers to pointers
	//What the hell is this..the answer is for love of polymorphism

	// Polymorphism

	struct sSomeBaseObject
	{
		virtual const char* IdentifyYourself() { // won't work 
			return "BaseObject";
		}
	};

	struct sSomeSubObjectA : public sSomeBaseObject;
	{
		const char* IdentifyYourself() {
			return "SubObjectA";
		}
	};

	struct sSomeSubObjectB : public sSomeBaseObject;
	{
		const char* IdentifyYourself() {
			return "SubObjectB";
		}
	};

	sSomeBaseObject objects[10]; // Our array is sSomeBaseObject based and hence virtual functions don't work.
	objects[3] = sSomeSubObjectA;
	for (int i = 0; i < 10; i++)
	{
		std::cout << objects.IdentifyYourself() << std::endl; //BTW Individual decleration and calling will work.
	}



	sSomeBaseObject** pSomeArray = new sSomeBaseObject[5];

	pSomeArray[0] = new sSomeBaseObject(); // All of them implement THE function
	pSomeArray[1] = new sSomeSubObjectA(); // So are array only consists of only one type of object
	pSomeArray[2] = new sSomeSubObjectB(); // But because of pointer every one have individuallity
	pSomeArray[3] = new sSomeBaseObject();
	pSomeArray[4] = new sSomeSubObjectA();


	for (int i = 0; i < 5; i++)
		cout << pSomeArray[i]->IdentifyYourself() << std::endl;

	for (int i = 0; i < 5; i++) delete pSomeArray[i];
	delete[] pSomeArray;

	std::vector<sSomeBaseObject*> vSomevector;

	vSomevector.push_back(new sSomeSubObjectA());
	vSomevector.push_back(new sSomeBaseObject());
	vSomevector.push_back(new sSomeSubObjectB());
	vSomevector.push_back(new sSomeBaseObject());
	vSomevector.push_back(new sSomeBaseObject());

	for (auto& a : vSomevector) // We are using & otherwise a copy will be created and deleted.
		std::cout << a->IdentifyYourself() << std::endl;

	for (auto& a : vSomeVector)
		delete a;

	vSomevector.clear(); // deletes the structure that represents the vector

	//What you should never do ever ever ever ever

	sSomeBaseObject* pPointerToVectorElement = &vSomevector[3]; // Cause vector fucking moves!!!

	//C and Cpp don't have garbage collectors, so  cpp intrduced smart pointers

	// Smart pointers - next file
	system("PAUSE");
}

// It is quite important to define the type of data pointers are pointing to
// why is this confusing, why they exist at all, there is no type of variable called pointer,
// it is infact just an integer.

// *b please declare me as a pointer
// *a please get the value pointed by the pointer
// hence **b

// ptr = ptr + 1 = ptr = ptr + sizeof(variable type of pointer)
```

```cpp
#include<iostream>
#include<vector>

using namespace std;

int main()
{
	struct sSomeObject
	{
		int x = 23;
		int y = 12;
		
		sSomeObject()
		{
			x = 232;
			y = 431;
		}

	};

	//Smart Pointers - Shared - Multiple accessors to pointer
	{//Scope 1
		std::shared_ptr<sSomeObject> spSomeObject1 = make_shared<sSomeObject>();
		{//Scope 2
			shared_ptr<sSomeObject> spSomeObject2 = spSomeObject1;
		}
	}

}
```