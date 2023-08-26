# Commands
https://www.youtube.com/watch?v=ZtqBQ68cfJc

### simple ones
~~~bash
whoami #prints the name of the currently logged in user
pwd #prints the current working directory
man #an interface to get manual on the commands
~~~

### touch
1. Other than opening a file it also updates it's timestamp, infact that's its actual purpose, so if the file already exists, it's new timestamp will be when the touch command was executed on it.
2. It can take mutiple filenames to create
~~~bash
touch blue green simplefile simplefile2
~~~

### mv
1. It can be used to move or rename file in the following way
~~~bash
mv filename new_filename
mv <PathToMoveFrom> <PathToMoveTo>
~~~

### cp
1. It can be used to copy and copy and rename
~~~bash
cp stuff new_stuff
cp <PathToMoveFrom> <PathToMoveTo>
cp -r     "              "  #To move all the contents in the dir not just a file
~~~

### head & tail
~~~bash
head filename -n 100 #will print the top 100 lines of a file
tail #this does similar thing but for the end of the file

head filename #simple command

tail -f filepath #this will open the file and keep updating the output buffer whenever a change occus in the file, might be usefull for logging error outputs etc log files.
~~~

### date
~~~bash 
date #print the current date and time
~~~

### > operator 
1. Reroutes the ouput of a command to anyfile or command.
2. '>' **won't append** but just create a new file or replace the content of existing file.
3. '>>' this will **append** the file
~~~bash
date > new.txt #will create a new file and store the file,
date >> new.txt
~~~


### cat 
1. cat will printout the entire contents of a file to the terminal output.
2. 'cat' comes from **cancatonate**.
~~~bash
cat txt1.txt txt2.txt txt3.txt > new_txt.txt #will concatenate all the files in order and put the output the new filei
cat -n <FilePath> #will output to the terminal and show the number of lines
~~~

### echo
~~~bash
echo "String" #will just print the string
echo "String" > test.txt #will insert the string into the file
echo "This is an example in $PATH" #supports environment variables
~~~

### wc
~~~bash
wc <FilePath> #will print the no. of lines, no. of words, no. of bytes
wc -l -w #will print only -lines and only -words 
~~~

### | operator
1. Called the **Pipe** operator
2. 'pipes' the output of one command and pushes it as input for the next command
~~~bash
cat file1 file2 file3 | wc # will print out the details of the resulting file

~~~

### sort 
1. Sorts the contents of a file.
~~~bash 
sort -f filename #ignore case
sort -n filename #by defaul will only sort by first digit, this option will allow
#numerical sort
sort -nu filename # -u -> only unique values printed

#another example

sort -un filename | wc -l
~~~

### uniq
1. Prints out **only adjacent** duplicate values.
2. But can also printout **only** repeated values.
~~~bash
uniq <FilePath> #print out all the values with adjacent non-unques removed
sort txt1.txt | uniq -d #will print out only the ones that are duplicated
~~~

### expansions
1. Some characters have special meaning to the shell and these can be interpreted when using commands.
2. They are automatically expanded when used.
~~~bash
echo ~ # will print the home dir
echo $PATH # will print the value

echo *.?? #print * (anything) . (followed by a dot) ?? (followed by any TWO chars)

echo {a,b,c}.{txt, py, cpp} # will print all the combinations

touch {a,b,c}.{txt, py, cpp} # will create all the combinations

mv {file1,fil2} <DirPath> # works
mv *.txt <DirPath> #works

echo {1..99} # will print 1 to 99 similarly
echo {a..z} 

~~~

### diff
1. Similar to how git shows differences created in files
~~~bash
diff file1 file2 # will print the differences between the two
diff -y f1 f2# shows both of them side by side
diff -u f1 f2 #gives some more info about the change
~~~

### find
1. Helps find the files matching some pattern
2. Can find files based on name, timestamp, extension etc.
~~~bash
find . -name '.py' #this will find the files in the current dir with specified properties.

find <PATH> <Parameters> <FileProperties> #find searches recursively

find . -name '7' #this looks for the exact match in ''

find . -name '*7*' #this will look for all the files with 7 in it.

find .. #this will recursive search all the dirs in the parent dir.

find . -type d #only print the files

find . -type f #only prints the files

find . -type d -iname '*E*' #will ignore case in the expression

find . -name '*E*' -or '*F*' 

find . -type f -size +100K -size -1M # print files with size between 100K and 1M

find . -type f -exec cat {} \; #find and then execute the following command on the found file

# \; is for teminating the statement, {} is filled with files names at execution
find . -type f -size +100K -exec ls -l {} \; 
~~~

### grep
1. Will search in files the info provided
~~~bash

grep txt FileOfText #will print the lines with the word 'txt' in em

grep -n # will print the line numbers

grep -n2 # two lines before and two line after

grep -r #Will recursively search through all the nested directories

grep -r "chiken" . #look recursively through all the dirs

grep -i # case insensitive

grep -rE -o "<RegularExpresion>" 
~~~

### du
1. Prints the size of dir and files
~~~bash
~~~

### df
1. Prints the disk usage 
~~~bash

df -h #pretty fun
df -h <DirName> #nice info
~~~

### history
1. Prints all last 15 commands
~~~bash

history #will print the the commands with numbers on lhs

!<CommandNumber> #will execute that command

history | grep 'cookie' #all the commands with 'cookie' in them

~~~

### ps
1. Prints the info about the processes across the system
~~~bash

ps axww | grep 'visual studio code' #will list the process with the precessor id

ps -x #all the processes

~~~







