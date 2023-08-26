# man
1. Returns the manual file that shows the documentaion for the requested command line tool. Ex:
	1. man ls
	2. man vim
	3. man man etc.
2.  man -k \<string\> will show all the manuals with that particular string in them, **apropos**, is another command that does the same thing. 
3. man -Tpdf ls | zathrua - :
	1. The above command will convert the resulting manual into pdf and then pipe the result to zathura (a pdf reader), the '-' symbol after zathura tells it to read from std output, thie will convert the manual into pdf and zathura will read and show it in a temporary file.
	2. '|' is the Linux or Unix pipeline operator. [[Pipelines]].
4. -T modifer can also output in other formats like -Tps for post script

# rm
1. rm -r to remove dirs, sudo rm -r to remove everything without verifying again.

