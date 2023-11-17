# os module python

~~~python
cwd = os.getcwd() #gives out the current working dir

os.chdir('../') #change the dir, just like in linux/unix term

#joining file paths and creating a new dir

#directory

directory = 'Arpit'

parent_dir = 'C:/Users/New Folder/'
directory = 'Arpit'

path = os.path.join(parent_dir,directory)

print("directory '%s' created", % directory) # print function

path = '/'

dir_list = os.listdir(path) #ls in python
print(dir_list)

path = ""
os.remove(path) # to dele the file the path leads
os.rmdir(path) # to remove the dir path leads to.

os.name # to get the OS name

os.error # for raising errors resulting form os operations.

#pipline using python

# 'os.popen(command[,mode, [bufize]])'

os.rename(file_oldnameOrpath,'NewName' )

os.path.exists(path) #bool true or false

os.path.getsize("filename") #returns file size in bytes


