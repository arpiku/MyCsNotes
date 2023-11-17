

```cpp
//This can be used for many things like timing the executions of code
//or to benchmark your code
// C++11 offers something called 'chrono' library this is platform independent
// however the OS also provide methods to time the code, and it may give the user some more control and 
// accracy, but this file will only cover the STL provided by the C++11 standard

#include<iostream>
#include<thread>
#include<chrono>

struct Timer
{
	std::chrono::time_point<std::chrono::steady_clock> start,end;
	std::chrono::duration<float> duration = 0; // The datatype is not a float, we are constructing a class using a template
										// using a float as a parameter
	Timer()
	{
		start = std::chrono::high_resolution_clock::now();
	}

	~Timer()
	{
		end = std::chrono::high_resolution_clock::now();
		duration = end - start;
		float MilliSeconds = duration.count() * 1000.0f; //To get answer in milli second
		std::cout << MilliSeconds << std::endl;

	}

};

void ForLoopToTime()
{
	Timer timethis; // As destructor will automatically get called at the end of the scope the time required by the for
				// will print
	for (int i = 0; i < 1000; i++)
	{
		// do something
	}
}


int main()
{
	using namespace std::literals::chrono_literals;
	auto start = std::chrono::high_resolution_clock::now(); // 'auto' keyword allows us to define varaible whose datatypes are not known
										//or are too long to type
	// now and the high_resolution_clock::now gives the current system time
	std::this_thread::sleep_for(1s); //Pauses our 'thread' for 1s

	auto end = std::chrono::high_resolution_clock::now();

	std::chrono::duration<float> duration = end - start;

	std::cout << duration.count() << std::endl;

	std::cin.get(); // Run it see what happens

	//The following line will print the time taken by the for loop in our function

	ForLoopToTime();
	std::cin.get();
}

// There are platform specific timing libraris like 'Win32' API
```