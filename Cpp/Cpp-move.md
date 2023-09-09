`std::move`
In C++, `std::move` is a utility function provided by the Standard Library that allows you to indicate that you want to treat an object as an rvalue reference, enabling move semantics. Move semantics are a way to efficiently transfer ownership of resources (such as dynamically allocated memory) from one object to another, without the overhead of deep copying.

Here's how `std::move` works:

1. **Converts to an Rvalue Reference**: `std::move` takes an lvalue (an object with a name) and converts it into an rvalue reference. Rvalue references are typically used for move operations.

2. **Enables Move Semantics**: Once an object has been cast to an rvalue reference using `std::move`, it can be used in move constructors or move assignment operators to efficiently transfer ownership of resources, such as memory buffers, from one object to another.

Here's a simplified example of how `std::move` can be used:

```cpp
#include <iostream>
#include <utility>

class MyString {
public:
    MyString() : data(nullptr), size(0) {}

    // Move constructor
    MyString(MyString&& other) noexcept {
        data = other.data;
        size = other.size;
        other.data = nullptr;
        other.size = 0;
    }

    // Move assignment operator
    MyString& operator=(MyString&& other) noexcept {
        if (this != &other) {
            delete[] data; // Release any existing resources
            data = other.data;
            size = other.size;
            other.data = nullptr;
            other.size = 0;
        }
        return *this;
    }

    ~MyString() {
        delete[] data;
    }

private:
    char* data;
    size_t size;
};

int main() {
    MyString source;
    // ...
    
    MyString destination = std::move(source); // Move constructor called
    
    source = std::move(destination); // Move assignment operator called
    
    return 0;
}
```

In this example, `std::move` is used to explicitly indicate that we want to transfer ownership of the `source` object's resources to the `destination` object. This enables the use of the move constructor and move assignment operator, which can efficiently perform the transfer.

It's essential to use `std::move` with care because it effectively "empties" the source object and can leave it in a valid but unspecified state. Move semantics are particularly useful for improving performance in situations where deep copying of resources is expensive or unnecessary, such as managing large data buffers or objects with exclusive ownership semantics.
## Why the move constructor?
You can use `std::move` on an object of a class even without explicitly defining move constructors and move assignment operators. However, the behavior of the move will depend on whether the class has user-defined move semantics or not.

If a class does not have user-defined move constructors and move assignment operators, C++ will generate them implicitly in many cases. The generated move operations will perform a shallow copy of data members, meaning they will copy the values of data members directly, rather than transferring ownership of any resources. This default behavior might be sufficient for many classes.

However, if a class manages resources like dynamic memory (e.g., using `new` and `delete` or smart pointers), or if it needs to perform specific actions when an object is moved (like clearing internal buffers), it's a good practice to define your own move constructor and move assignment operator to ensure correct resource management and proper behavior during moves.

In the code example I provided earlier, I explicitly defined move constructor and move assignment operator for the `MyString` class to illustrate how you can customize the behavior of move operations when transferring ownership of resources. If you have a class that doesn't manage resources or doesn't require any special actions during moves, you may not need to define these functions explicitly, and C++ will provide default implementations for you.

So, to clarify, you can use `std::move` with a class without explicitly defining move operations, but the behavior of the move (e.g., shallow copy vs. transferring resources) depends on whether the class has user-defined move semantics or relies on the default behavior provided by C++.

## What was that '&&' operator?
The `&&` symbol in C++ serves different purposes depending on where it is used:

1. **Rvalue Reference**: In function parameter lists and variable declarations, `&&` represents an rvalue reference. An rvalue reference allows you to bind to temporary objects (rvalues) and is primarily used for enabling move semantics. For example:

   ```cpp
   int x = 5; // x is an lvalue (a named variable)
   int&& y = 10; // y is an rvalue reference to an rvalue
   ```

   In this example, `y` is an rvalue reference that can bind to the temporary integer `10`. This feature is essential for move constructors and move assignment operators, as it allows you to efficiently transfer ownership of resources from one object to another.

2. **Logical AND Operator**: In expressions, `&&` is the logical AND operator. It is used for performing logical AND operations on boolean values. For example:

   ```cpp
   bool a = true;
   bool b = false;
   bool result = a && b; // result is false
   ```

   Here, `result` will be `false` because `&&` evaluates to `true` only if both `a` and `b` are `true`.

So, `&&` can represent an rvalue reference in certain contexts, enabling move semantics, and it is also used as the logical AND operator for boolean operations. These two usages are distinct and unrelated.

## What are Rvalues and Lvalues
In C++, the terms "lvalue" and "rvalue" are used to categorize expressions based on their behavior and usage. Understanding these concepts is essential for working with C++ and understanding how values can be manipulated or assigned.

1. **Lvalue (Left Value)**:

   - An lvalue refers to an expression that represents a memory location or an object that has a name.
   - Lvalues can appear on the left side of an assignment operator (`=`) because they represent storage locations that can be modified.
   - Examples of lvalues include variables, named objects, and elements of arrays.

   ```cpp
   int x = 5; // 'x' is an lvalue
   int arr[10]; // 'arr' is an lvalue
   ```

2. **Rvalue (Right Value)**:

   - An rvalue refers to an expression that represents a value or a temporary object that doesn't necessarily have a persistent, identifiable memory location.
   - Rvalues can appear on the right side of an assignment operator (`=`) because they represent values that can be assigned to an lvalue.
   - Examples of rvalues include literals, the result of arithmetic expressions, and the return values of functions that aren't references.

   ```cpp
   int y = 10; // '10' is an rvalue
   int z = x + y; // 'x + y' is an rvalue
   ```

Now, let's understand how lvalues and rvalues relate to C++ features:

- **Assignment**: An lvalue can appear on the left side of an assignment (`=`) because it can be assigned a new value.
- **Initialization**: When you declare and initialize a variable, the expression on the right side is typically an rvalue because it represents a value that is being assigned to an lvalue (the variable).
- **Passing Arguments**: When you pass an object to a function, whether it's treated as an lvalue or an rvalue depends on the context. If the object is passed by reference, it's treated as an lvalue; otherwise, it's treated as an rvalue.
- **Move Semantics**: Rvalue references (`&&`) are used to bind to rvalues, enabling efficient move semantics in C++. This is essential for resource management and performance optimization.

Here's an example that demonstrates the distinction between lvalues and rvalues:

```cpp
int x = 5; // 'x' is an lvalue
int y = 10; // '10' is an rvalue
int z = x + y; // 'x + y' is an rvalue on the right side of the assignment
```

In this example, `x` and `y` are lvalues because they are variables with names and can be modified. The result of the expression `x + y` is an rvalue because it represents a temporary value that can't be directly assigned to. Understanding lvalues and rvalues is crucial for proper C++ programming, especially when dealing with features like move semantics, references, and function parameter passing.

# What does `noexcept` do?
In C++, `noexcept` is a keyword used to declare and specify exception specifications for functions. It indicates whether a function can throw exceptions or not. It is primarily used for two purposes:

1. **Exception Specification**: `noexcept` can be used in a function's declaration to specify whether that function may throw exceptions. You can use it in two ways:

   - `noexcept`: This indicates that the function does not throw any exceptions. If it does throw an exception, the program will terminate. This is sometimes called a "noexcept specification."
   - `noexcept(expression)`: This allows you to specify a condition under which the function may throw an exception. If the condition evaluates to `true`, the function is declared as potentially throwing an exception; otherwise, it's declared as not throwing.

   For example:
   ```cpp
   void foo() noexcept; // foo() won't throw any exceptions
   void bar() noexcept(false); // bar() may throw exceptions
   void baz() noexcept(sizeof(int) > 4); // baz() may throw exceptions if int size is greater than 4
   ```

2. **Exception Handling Optimization**: `noexcept` can also be used in the context of move constructors and move assignment operators to indicate that these functions won't throw exceptions during resource transfers. This information is essential for certain optimizations, particularly when working with the C++ Standard Library's containers and algorithms.

   When a move constructor or move assignment operator is marked with `noexcept(true)`, it enables certain optimizations. If a container or algorithm knows that a move operation won't throw exceptions, it can use a more efficient algorithm to manage resources. This is especially important for improving performance in scenarios where exceptions are costly, such as real-time or embedded systems.

   For example:
   ```cpp
   class MyString {
   public:
       // Move constructor marked as noexcept
       MyString(MyString&& other) noexcept {
           // ...
       }
   };
   ```

In summary, `noexcept` is a keyword used to declare whether a function can throw exceptions and can also be used to optimize move operations by specifying that they won't throw exceptions. It helps with both code clarity and performance optimization in error-handling scenarios.


## ChernoCpp
```cpp
//MOVE SEMANTCIS
//

// When you are creating a copying a value, for the resons such as 
// passing it to function, or returning,  an extra throw away of 
// copy is needed to made, this becomes a problem and heapt allocation need
// to performed, it becomes a 'heavy object'
//

#include <iostream>

class String{
	String() = default;
	String(const char* string) {
	
	}

```

