#rustOwnership #memoryManagement 

- Rust is a multi-paradigm language created by [[Graydon Hoare]].
## What is borrowing?
#basic
- When a program runs the runtime data is stored either on a **stack** or a **heap.
- With stack we already have a predefined space that is used in LIFO manner.
- With heap allocation the program finds a large enough space in the memory to store what is needed to be stored and then returns a pointer to the location.

## Primitives in Rust

## Integers:
```Rust
//There are various types of integers
i32, i64, .. i128, arch
u32, u64 ... u128
```


## Rules of Ownership in Rust:
This is done by adhering to the following three main ownership rules:

- Rule 1: _Each value in Rust has an owner._
- Rule 2: _There can be only one owner at a time._
- Rule 3: _When the owner goes out of scope, the value will be dropped._

