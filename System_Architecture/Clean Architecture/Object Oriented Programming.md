### What is OOP?
- There are mulitiple answers depending on who you ask.
	- "The combination of data and functions" some people proclaim!
	- "A way to model the real world!".
	- "And some people throw the usual, encapsulation, Inheritence, And polymorphsim."

All these answers are unstatisfactory and somewhat evasive in nature. Was it not possible to achive these behaviours before OOP became the famous standard?

The answe is YES, you could have achiveed similar behavior like these.
### Encapsulation:



- **point.h**
```c
struct Point;
struct Point* makePoint(double x, double y);
double distance(struct Point* p1, struct Point* p2);
```




```
```c
#include"point.h"
#include<stdlib.h>
#include<math.h>

struct Point {
double x, y;
}

struct Point* makePoint(double x, double y) {
struct Point* p = malloc(sizeof(struct Point));
p->x = x;
p->y = y;
return p;
}


double distance(struct Point* p1, struct Point* p2) {
double dx = p1->x - p2-x;
double dy = p1->y - p2-y;

return sqrt(dx*dx + dy*dy);
}
```

In the above example we successfully achived encapsulation, the user of makePoint and Point have no idea about the internal variable x and y. 
They are just aware of the operations the object can perform, the what is the point of OOP encapsulation??

In C++ however
- **point.h**
```cpp
class Point {
private:
	double x;
	double y;
public:
	distance() {
	...};
	Point() {
	....};
}
```
- **Point.cpp**
```cpp
#include<point.h>
#include<math.h>

Point::Point(double x, double y)
:x(x), y(y)
{}

double Point::distance(const Point& p) const {
double dx = x-p.x;
double dy = y-p.y;
return sqrt(dx*dx + dy*dy);
}
```


## Inheritence
- This one is important though, the ease with which modern inhertence can be implemented is actually pretty great.
- 