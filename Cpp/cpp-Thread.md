- [[cpp - Parallel Programming]] #parallelprogramming #promisesFutures #threading 
The class `thread` represents [a single thread of execution](https://en.wikipedia.org/wiki/Thread_(computing) "enwiki:Thread (computing)"). Threads allow multiple functions to execute concurrently.

Threads begin execution immediately upon construction of the associated thread object (pending any OS scheduling delays), starting at the top-level function provided as a [constructor argument](https://en.cppreference.com/w/cpp/thread/thread/thread "cpp/thread/thread/thread"). The return value of the top-level function is ignored and if it terminates by throwing an exception, [std::terminate](https://en.cppreference.com/w/cpp/error/terminate "cpp/error/terminate") is called. The top-level function may communicate its return value or an exception to the caller via [std::promise](https://en.cppreference.com/w/cpp/thread/promise "cpp/thread/promise") or by modifying shared variables (which may require synchronization, see [std::mutex](https://en.cppreference.com/w/cpp/thread/mutex "cpp/thread/mutex") and [std::atomic](https://en.cppreference.com/w/cpp/atomic/atomic "cpp/atomic/atomic"))

- So basically think of thread as one of the many powerful programable machines you have inside your processor, we ignore the value of the thread, if it ends up having an error in other cases, we can communicate using return values, `std::promise` or by modifying shared variables.
- Following is pseudoClass in Cpp to show the available operations:
```cpp
class thread {
private:
	id;
public:
	thread() {
	//construcutor;
	}
	~thread() {
	//destructor;
	}
	thread& operator=( thread&& other ) noexcept; //cpp11
//........
```
- The "=" operator can be used to join a right side thread to the left side, if join is possible, it terminates the thread and assigns it the value of the new thread and completes the execution.
- After this call, [this->get_id()](https://en.cppreference.com/w/cpp/thread/thread/get_id "cpp/thread/thread/get id") is equal to the value of [other.get_id()](https://en.cppreference.com/w/cpp/thread/thread/get_id "cpp/thread/thread/get id") prior to the call, and `other` no longer represents a thread of execution.
```cpp
//.....
// observers
bool joinable() {
....//code that tell whether the thread is joiniable
};
id get_id() {
//returns id();
}

auto native_hanlde() {
// returns the underlying implementation-defined thread handle  
}

auto hardware_concurrency() {
// returns the number of concurrent threads supported by the implementation
}

//Operations:
join() {
//waits for thread to finish it's execution
}

detach() {
//permits thread to do exectution independently
}

swap() {
//swaps two thread object
}
```
- jthreads are similar to threads in most ways but have special functinality called **Stop token handling** more can be found here [[cpp-jThread]]