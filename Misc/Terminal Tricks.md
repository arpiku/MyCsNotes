#### Copy a file to clipBoard without opening it
- MacOS
```bash
cat file.txt | pbcopy
```
- Linux
```bash
xclip -selection clipboard -i < file.txt
```

### Recreate a dir structure with only the required files
```bash
find . -name '*.cpp' -exec cp --parents \{\} ~/Coding \;
```