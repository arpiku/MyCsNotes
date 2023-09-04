
## Concurrency Vs Parallelism:
- **Concurrency:** Means doing things concurrently, maybe switching between them.
	-  Like chopping onions
	- Stirring the food.
- **Parallism** : Doing things simultaneously
	- Stirring the food.
	- Talking on phone.

In broad strokes, parallel programming is a hardware problem while concurrency is more of a software problem, i.e hyper-threading etc.
We didn't have concurrency in the standard till #cpp11 , we had third party libraries but that means the standard had no goverance over how multithreading should be done in C++.

The above slide shows that we need **data mutation protection**, when one thread is accessing it, other threads are not allowed to modify that data.
**Synchronisation** is important to know that when you are not looking at the variable while the thread is modifying it.

Interesting: The level of abstraction leads to a situation where the hardware has a say in how the code will work internally, hence the actual code you write may not represent the actual way things are happening on the hardware.

So in C++, we rely on the gurantees provided by the standard and use them to properly design our program.

In #cpp11 we could call the functions set up a thread as follows:
```cpp
std::thread t1 = std::thread([]() {
long int sum = 0
for(int i = 0; i<1000000; i++)
	sum+=i;
return sum;
})
```
- **The above code starts execution immediately.**

- Also the example shows you can pass a callable object into the constructor of a thread.

- **Once the thread does it's job it stops and becomes joinable**.



## Example of a data race condition:
```cpp
using SC = std::chrono::steady_clock;
auto deadline = SC + std::chrono::seconds(10);
int counter = 0;
std::thread threadB = std::thread([&](){
while(SC::now() < deadline) 
	printf("B : %d\n", ++counter);
});
while(SC::now() < deadline) 
	printf("A: %d\n", ++counter);
threadB.join();
```

The following magically fixes everything
```cpp
using SC = std::chrono::steady_clock;
auto deadline = SC + std::chrono::seconds(10);
std::atomic<int>  counter = 0;
std::thread threadB = std::thread([&](){
while(SC::now() < deadline) 
	printf("B : %d\n", ++counter);
});
while(SC::now() < deadline) 
	printf("A: %d\n", ++counter);
threadB.join();
```



