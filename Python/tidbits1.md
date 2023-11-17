```python
def print_combinations_with_repeating_characters(v, current_combination=[]):
    if len(current_combination) == len(v):
        print(''.join(current_combination))
        return

    for i in range(len(v)):
        current_combination.append(v[i])
        print_combinations_with_repeating_characters(v, current_combination)
        current_combination.pop()

# Example usage:
v = [1, 2, 3]
print_combinations_with_repeating_characters(v)
```