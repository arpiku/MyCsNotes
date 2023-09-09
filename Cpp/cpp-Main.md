
```cpp
// Threads are way to parallelize our code
// Earlier our code was running on one thread, that means that our code was running on a single core of you CPU
// A single core of CPU or GPU can one do one instruction at a time, this is why mordern machines have multiple cores
// so that the work can be distributed across multiple cores, imagine playing games and streaming at the same time
// both process will run on different cores

// This is EXTREMELY powerful tool, now not all calculations can be done parallely
// Something like calculating fibonacci series where one needs that previous value to calculate the next cannot be 
// done parallely, however something like rendering a game can be done parallely, as the equations can be solved 
// seperatly without effecting other calculations.This is why GPU have hundreds of cores.

#include<iostream>
#include<thread> // Header required to have multiple thread

static bool s_WorkDone = false;

void Task1()
{
	using namespace std::literals::chrono_literals;
	while (!s_WorkDone)
	{
		std::cout << "Going on\n" << std::endl;
		//std::this_thread::sleep_for(1s); // Pauses thread for 1s otherwise it will use the whole CPU core for processing
	}
}



int main() // Your main function runs on one main thread
{
	std::thread Thread1(Task1); // this will be running on a different thread
	std::cin.get();
	s_WorkDone = true; // Our main thread is waiting for input while the other thread is simultaniously performing prints
	std::cout << "Finished" << std::endl;


		// Now our thread has been turned off and due to above statement


	Thread1.join();

	std::cin.get();
}
```