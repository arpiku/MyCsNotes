- Creating Classes
```cpp
#include<iostream>
#include<string>

using String = std::string;

class Entity
{
private:
	String m_Name;
public:
	Entity() :m_Name("Unknown") {}
	Entity(const String& name) : m_Name(name) {}

	const String& GetName() const { return m_Name; }
};

int main()
{
	Entity entity; // Unique to Cpp
	Entity name = Entity("Cherno"); // Good
	Entity name2("Arpit"); // Why, scope of existance is the answer

	Entity* e;
	{
		Entity test = test("name");
		e = &test;
		std::cout << test.GetName() << std::endl;
		
		

	} // at this point the entity will be deleted as it is decleraed on the heap

	Entity* e2;
	{
		Entity* entity2 = new Entity("Cherno"); // Java and C# style
	     e2 = entity2;
	    std::cout << entity2->GetName() << Std::endl; 
	}// New is slow and manual  deletion

	Entity* e = (Entity*)malloc(sizeof(Entity); // doenst call the constructor
	free(e); //doesn't call destructor
	
	delete e2;
	delete e;
	std::cout << entity.GetName() << std::endl;
	std::cin.get();

}
```

```cpp
#include<iostream>
#include<string>

class test {
private:
	int x = 0;
public:
	test() {
		std::cout << "Create Entity" << std::endl;
	}

	test(int x) {
		std::cout << "Created Entity with" << x << std::endl;
	}
	void SetX(int a)
	{
		x = a;
	}


};
class Entity
{
private:
	std::string m_Name;
	test Test;
	int m_Score;
public:
	Entity()
		:Test(8), Test(test(8))
	{
		Test = test(8);
	}
	Entity()
	{
		m_Name = "Arpit";
		
	}
	Entity(const std::string& name)
	{
		m_Name = name;
	}
	Entity()
		: m_Name("Unknown"), m_Score(0) {} // Order is important
	Entity(cosnt std::string& name)
		:m_Name(name) {}
	const std::string& GetName() const { return m_Name; };
	Entity()
		:x(0), y(0), z(0) {} // to hide stuff

};

int main()
{
	Entity e0;
	std::cout << e0.GetName() << std::endl;

	std::cin.get();
}
// Why ?
// For better readability, keeps code clean BUT for classes
//functionally , if you don't initialize with MIL , your object will be constructed twice
// it helps to avoid copies
```