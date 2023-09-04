import os

names = ["list", "forward-list", "set", "multiset", "map", "multimap", "unordered_map", "unordered_multimap", "unordered_set", "unordered_multiset", "stack", "queue", "priority_queue", "falt_set",
"flat_multiset", "flat_map", "flat_multimap", "span", "mdspan"]

curr_dir = os.getcwd();

for name in names:
	file_path = os.path.join(curr_dir,str("cpp-"+name+".md"))
	try:
		with open(file_path, "w"):
			pass
		print(f"created file: {name}") 
	except Exception as e:
		print(e)

