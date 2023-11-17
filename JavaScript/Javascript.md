## Node notes
- Node is written in C++
- R&W files on the server and serve them on the internet
- Connect to a database
- Act as a server for content

- Node > C++ > Assembly Lang> Machine code

## Benefits
- Same lang on frontend and backend


##
- fetch can both retrieve and send data, 
1. Call fetch(__PATH__) .  // It works asyncronously
2. response (Body (JSON, XML))
3. Complete datastrea
4. Make an img element.

## Some stuff
- There are other engines to such as SpiderMonkey of FireFox, where the engine is written in C++ and uses JIT compiler called IonMonkey and also provides a garbagecollector.

- Everything in JS is heap located, except smis(small integers)

Engines are complicated. But the basics are easy.

    - The engine (embedded if it’s a browser) reads (“parses”) the script.
    - Then it converts (“compiles”) the script to machine code.
    - And then the machine code runs, pretty fast.

There are browser specific commands as well such 'alert' 
use <script></script> tag to write the JS code in HTML, 
XML (eXtensible markup langugage)

Modern HTML changed the usage of 'script', it is not required anymore, but in mordern HTML totally changed the meaning of the attribute,now it can be used to call JS modules.

-- Larger Scripts are stored as seperate files this allows them to be cached by the browser, then the browser can directly use it,
whereever it is called without requiring to redownload the same stuff.

## What are statments?
- Statements are syntax constructs or commands that make actions happen.
- JS considers line breaks as an 'implicit' semicolon, this is called automatic semicolon, this is not the case when an expression is
being carried for multiple lines (But this fails sometimes) 
- ```JS alert("Hello") 
[1,2].forEach(alert)``` // This will throw a TypeError, the reason being JS considering it all as a single statement, when it should have been 
```JS alert("HELL"); [1,2].forEach(alert)``` // Take precaution **** Important point here.

## Moder way
'use strict' // Works only when implemented before the acutal code starts, is scope dependent, can be made to work only inside a function.
// doesn't directly work on older browsers, some newere ones are fine, a trick to make it work on older browser:

<!-- ```JS 
(function() {
    'use strict';
    //code
})(); ```  -->

## variables
- multiple decleration in single line are supported.
- variable names are alpharnumeric + '$' + '_'
- Non-latin names are also allowed


## DataType
    - Number 

## "var" vs "let"
-  "var" is hoisted to the top, hence even if it is declared below it's use it will work.
- It is not scope specific, i.e it is available even the scope of (function/ loops/ etc) ends.
- funny enough this code will work ``` function() { msg = "Hello"; alert(msg); if(false) {var msg}}.
- The declaration is "hoisted" up however the assigment is not, hence if in the above code the msg was assigned afte the function is 
called the output will be 'undefined'
- var declarations are processed when the functions starts( or scripts starts for globals),  in other words vars are defined from the 
beginning.
- you can use the same name as a variable already declared (that is not the case for 'let' and the behaviour is opposite in all the previous cases as well).
-IIFE (Immediatly-invoked function expressions), a trick to make var behave in scope, the '(' to let us call a fucntion without a name, 
as it being defined in context of something else.









## More notes
- ; terminates statements
- Problem with the floatin point arthimatic exists
- Three non-numerical values (+-Infinity, NaN);
- Precedence is enforced with parentheses
- Strings work with either ' or "
- === and !== for equal & not equal
- Strings can be concatenated with '+'
- Type coersion can be perfomed with '==', ie "5" == 5,
- null == undefined but null !== undefined
- 13 + !0 = 14, "13" + !0 = '13true'
- Strings can be accessed similar to array, like "String".charAt(0) = 'S'

## Interactions:
APC (alert, prompt, confirm)

## Conversions:
- Strings are converted to numbers
There are conversion rules:
undefined -> NaN
null -> 0
true and false -> 0 or 1
string -> White spaces removed, if not number, then NaN

A non-empty string results in a true to boolean conversion and ANY string non-empty string results in true.


String conversion takes priority over number conversion i.e ("1" + 2 + 2) is "122"

## Some Pointers
- There are browser specific funtions as well.
- JS was written as scripting contained within the browser environment to play around with the elements and make it dynamic,
- late the use expaned to a general programming language using runtime environments called engines such v8, SpiderMonkey.