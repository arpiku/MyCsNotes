# Just some basics

# Ternary operations in Python

from matplotlib.cbook import ls_mapper


bool = True
if(bool):
    x = 1
else:
    x = 0
print(x)

# We can do the above operation like this 
# x = 'this' if condition else 'that'

bool = not(bool)
print(bool)
x = 1 if bool else 0

print(x)

## Handlingn large number to making them easy to read

foobarnum = 10000_000_000
print(foobarnum)
print(f'{foobarnum:,}')  # ':' are important

## Code that smells
f = open('requirements.txt', 'r')
file_contents = f.read()
f.close()   

words = file_contents.split()
words_count = len(words)
print(words_count) # this code is not good, as we might foget to clost the file, the idea 
# is that the code is unsafe, one should lookout for situtions where resources are being
# handled manually

# we can use something called 'conrequirements manager'

with open('requirements.txt', 'r') as f:
    file_contents = f.read()

# the conrequirements mangager will now manage the resources and make sure things don't go to
# shit, let's hope whoever wrote it knew what they were doing.
# this is also important for database connections and threads.




