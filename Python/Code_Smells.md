## Python Code smells
1. Using string where a enum should be used:
	```python
	from enums import Enum, auto

	class entity(Enum):
	a = auto()
	b = auto()
	c = auto()
```
2. Avoid duplicate code, use generic functions.
3. Use built in tools like list comprehension
4. Giving names to variables with directly understandable meaning, i.e non-vague identifiers.
5. Seperate behaviour, make is make sense.
6. If not doing anything with the exeption then don't raise it in the first place.
7. Create your own exeption
```python
class LOL(Exception):
	#do stuff.
	
```
8. **Feature Envy**, taking too many parameters, suggesting either a merger or spliting of funcions.
9. **Too deep nesting**
10. **Not using the correct data structure**
11. **Import the specific things you need**, don't use the wild card '*'.
12. **Avoid code asymmetry**
13. **Using self when no needed**  don't just use it anywhere.