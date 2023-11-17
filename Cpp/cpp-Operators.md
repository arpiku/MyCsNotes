```cpp
// Operator is a symbol that is equivalent to a function <<,>>, new , delete, , ,(),
// overloading +>, giving new meaning too,new defination , adding methods etc

// C++ gives you full control, C# partially , java doesnt 
// Good and bad at the same time, they are just functions, use should be minimal, and
// it should make perfect sense

#include<iostream>
#include<string>

struct Vector2
{
	float x, y;

	Vector2(float x, float y)
		:x(x), y(y) {}

	Vector2 Add(const Vector2& other) const
	{
		return Vector2(x + other.x, y + other.y);
	}

	Vector2 Multiply(const Vector2& other) const
	{
		return Vector2(x * other.x, y * other.y);
	}

	Vector2 operator+(const Vector2& other) const
	{
		return Add(other);
	}

	Vector2 operator*(const Vector2& other) const
	{
		return Multiply(other);
	}

	bool operator==(cosnt Vector2& other) const
	{
		return x == other.x && other.y;
	}
};

std::ostream& operator<<(std::ostream& stream, const Vector2& other)
{
	stream << other.x << "," << other.y;
	return stream;// ref. to stream

}



int main()
{
	Vector2 position(4.0f, 4.0f);
	Vector2 speed(0.5f, 1.5f);
	Vector2 powerup(1.1f, 1.1f);
	
	Vector2 result = position.Add(speed.Multiply(powerup));// Without overloading

	Vector2 result2 = position + speed; //*powerup;

	std::cout << result2 << std::endl;

	//but what if we wanted to modify our speed now ?!?
	//things then start to get complicated
	//the above is the truth for java

	std::cin.get();

	// is like ToString

	if (!result2.equals(result)); // will have to write equals function(java)
	// but we can overload

}
```