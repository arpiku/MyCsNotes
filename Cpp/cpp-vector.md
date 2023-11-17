### ChernoCpp
```cpp
#include<iostream>
#include<vector>
//first optimizatin code, you should know your environment
//how to optimize your vector, so we remeber how the vector works
//today we will try to optimzing for copy

struct Vertex
{
	float x, y, z;
	Vertex(float x, float y, float z)
		:x(x), y(y), z(z)
	{
	}

	Vertex(const Vertex& vertex)
		:x(vertex.x), y(vertex.y), z(vertex.z)
	{
		std::cout << "Copied!" << std::endl;
	}
};

std::ostream& operator<<(std::ostream& stream,const Vertex& vertex)
{
	std::cout << vertex.x <<vertex.y << vertex.z << std::endl;
	return stream;;
}

int main()
{
	std::vector<Vertex> vertices;
	std::vector<Vertex> vertices2;
	//std::vector<Vertex> vertices2[3];
	//std::vector<Vertex> vertices3(3)
	vertices.reserve(3);
	vertices.push_back({ 1,2,3 });
	vertices.push_back({ 4,5,6 });
	vertices.push_back(Vertex(6, 7, 8)); // vector also get resized something to be 
	//avoided
	// if we knew the size just allocate directly
	// Six copied fuck!
	vertices2.reserve(3);
	vertices2.emplace_back(1, 2, 3); // the constructor now doesn't get called by 
	// copying everything but the data is still stored
	vertices2.emplace_back(2, 3, 4); //stops the copying
	vertices2.emplace_back(4, 5, 6);

	for (Vertex& v: vertices2)
		std::cout << v << std::endl;


	std::cin.get();

	// The object is first created in the main class then it needs to transported to 
	// the memory where the vector is stored, the vertex class
	// what if we can just construct the vertex in the memory that has been allocatd
	// by the vector

}
```
