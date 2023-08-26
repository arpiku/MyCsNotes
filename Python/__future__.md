-   To avoid confusing existing tools that analyze import statements and expect to find the modules they’re importing.
    
-   To ensure that [future statements](https://docs.python.org/3/reference/simple_stmts.html#future) run under releases prior to 2.1 at least yield runtime exceptions (the import of [`__future__`](https://docs.python.org/3/library/__future__.html#module-__future__ "__future__: Future statement definitions") will fail, because there was no module of that name prior to 2.1).
    
-   To document when incompatible changes were introduced, and when they will be — or were — made mandatory. This is a form of executable documentation, and can be inspected programmatically via importing [`__future__`](https://docs.python.org/3/library/__future__.html#module-__future__ "__future__: Future statement definitions") and examining its contents.

# Note
Basically it is a tool used to make sure the code from before python2.1 can be compatiable with newer releases.