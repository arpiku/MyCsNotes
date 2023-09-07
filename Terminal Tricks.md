- Copy a file to clipBoard without opening it
- MacOS
```bash
file.txt > pbcopy
cat file.txt | pbcopy
```
- Linux
```bash
xclip -selection clipboard -i < file.txt
```


