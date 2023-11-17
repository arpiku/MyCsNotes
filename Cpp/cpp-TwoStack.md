```cpp
#include<iostream>

#define MAX 6
#define LOG(x) {std::cout << x;}


class TwoStack
{
private:
	int S[MAX];
	int bottom;
	int top;
public:
	TwoStack()
		:S{ 0 }, bottom(-1),top(MAX) {} // Intitializing variables

	int pop_bottom()
	{
		if (bottom != -1)
			return S[bottom--]; // returns bottom and then decrements
		LOG("UNDERFLOW! STACK 1");
		return 0;
	}

	void push_bottom(int input)
	{
		if (bottom != MAX/2)
			S[++bottom] = input; // increments bottom and then pushes input
		else
		{
			LOG("OVERFLOW! STACK 1");
		}
	}

	int pop_top()
	{
		if (top != MAX)
			return S[top++]; // returns top and then increments
		LOG("UNDERFLOW! STACK 2");
		return 0;
	}

	void push_top(int input)
	{
		if (top != (MAX/2 + 1))
			S[--top] = input; // decrements top and pushes input
		else
		{
			LOG("OVERFLOW! STACK 2");
		}
	}


	bool IsEmptyTwoStack() { return (bottom == -1 && top == MAX); } // Will return 1 if empty or 0 otherwise
	bool IsEmptyStack1() { return (bottom == -1); }
	bool IsEmptyStack2() { return (top == MAX); }

};

int main()
{
	TwoStack twosided;
	std::cout << "Is Stack Empty :" << twosided.IsEmptyTwoStack();
	LOG("\nPushing item from bottom..\n"); LOG("123 pushed ...\n");
	twosided.push_bottom(123); // pushing from bottom
	LOG("STACK_1 empty check :"); std::cout << twosided.IsEmptyStack1() << '\n';
	LOG("STACK_2 empty check :"); std::cout << twosided.IsEmptyStack2() << '\n';
	LOG("Pushing from the top..\n");
	twosided.push_top(567); LOG("567 pushed ...\n");
	LOG("STACK_1 empty check :"); std::cout << twosided.IsEmptyStack1() << '\n';
	LOG("STACK_2 empty check :"); std::cout << twosided.IsEmptyStack2() << '\n';
	LOG("Popping out everything...\n");
	LOG(twosided.pop_top()); LOG(", " << twosided.pop_bottom() << "\n"); 
	LOG("STACK_1 empty check :"); std::cout << twosided.IsEmptyStack1() << '\n';
	LOG("STACK_2 empty check :"); std::cout << twosided.IsEmptyStack2() << '\n';

	std::cin.get(); return 0;
}
```