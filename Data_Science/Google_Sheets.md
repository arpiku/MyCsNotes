# Notes for google sheets
1. Google sheets and Excel provide exellent tools for arranging and visualizing data, this will be a look at the tips and triks for the google sheets.
2. Visualizing is extremely important for understanding data. [[Data_Visualizing_Tools]].
	1. ANSCOMBE'S QUATRET : Sometimes when overlying value might be similar in nature, this does not represent the granularities in data, visualizing it however might reveal these differences.  
	2. IMg
	3. We also get intutive results from data, make us capable of asking better questions, this gives better insight, *start with graphs and go to numericals next*
3. *Freezing rows and columbs* in a spreadsheet, just move the thick line.
4. *Quick Sum* for quick look at averages, sum, etc of the selected numbers.
5. Txt is usually flush left and opposite is true for numbers.
6. The concept of _TIDY DATA_  [[tidy-data.pdf]].
# Tidy Data
1. The goal is to create data that is easily migratable, *column* and *variables* are synonyms for our purpose, also *rows* and *observations* are the same.
2. Data sets need to be organized such that sharing the data is easy, so that they can easily take the data out to other application or some sort of code based pipeline.
3. **Don't use merged cells** 
4. **Simplify** Use 0 or 1 for binary data.
5. **If Data repeats itself a lot** seperate the sheet for that repeated set of data.

# Back to tricks
1. Pattern in cells can be propated easily.
2. Chat history disappears one's the file is closed.
3. Comments can be **Resolved**.
4. Sorting over multiple columns is possible like in [[MongoDB_Aggregation]], #MongoDB_Sort, but in this the methods is kinda opposite as the values with which you want to sort first need to given the sort command in the last step, i.e if you want to sort 1st by 'a', 2nd by 'b', and then 3rd by 'c', it would go sort {c,b,a}. 
# Filtering
1. That funnel like thing on the top right side.
2. Can be used to look at particular data only, it also allows 'filter by condition'.
3. One can also create *filter views*, basically labelled filter conditions that can be saved and be viewed later, like saved aggregation in MongoDB.

# Publishing 
1. Sheets can be publised as documents using links that lead to an interactive web page.
2. Or one can publish it as vanilla .csv, .xls files etc.
3. It's mostly useful when sharing interactinve graphics with people.

## Version History
1. Something similar to [[Git]] to see who made what changes, with colour codes cells.

## Dealing with outliers


Scale Factor in graph options divides the data by the selected value.


## Interactive Data
1. **Timeline Chart** gives one some interactive capabilities based on the x-axis, like little buttons and sliders to interact  with the data.
2. SPARKLINE, creates a very small inline graph, that is represented right in the data. 
3. **Edward Tufte** 
4. SPARKLINE('range', {'ymin', 0}), sets the minimum 'y' value to 0.


## $ Sign 
1. It is an operator that makes the inserted cells constant, in the sense that dragging the domain of the input cells won't change the input cells, they would remain constant. 
	1. E.g {J$2:J$8}
2. This is used to create a relative or absolute reference.
3. It acts on the value directly preceding it.

## Some common formulas
1. COUNT(Fields) = Give out the count of numerical values
2. COUNTA(Fields) = Gives out the count of all the cells with any alpha numeric value
3. SUM(Fields) = Gives out the sum of selected cells.
4. MEAN(Fields) = Gives out the avg of the selected cells.


## & operator
1. Concatenates the given values 