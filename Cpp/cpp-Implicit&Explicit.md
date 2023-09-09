```cpp
#include<iostream>
#include<string>

class Entity
{
private:
	std::string m_Name;
	int m_Age;
public:
	Entity(const std::string& name)
		:m_Name(name), m_Age(-1) {}

	explicit Entity(int age)
		:m_Name("Unknown"), m_Age(age) {}

};

void PrintEntity(const Entity& entity)
{
	//Print
}

int main()
{
	PrintEntity(22); //Still works
	PrintEntity("Cherno"); // Won't work, only one implicit type conversion allowed
	PrintEntity(std::string("Cherno")); // Will workd
	PrintEntity(Entity("Cherno"));
	Entity a = "Cherno"; // unique to cpp
	Entity b = 22; //with explicit doesn't allow this.
	Entity c(22); // Better
	std::cin.get();
}
```