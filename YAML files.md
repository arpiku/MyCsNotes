- YAML ain't mark up language.
- It is to define data to exchange data, similar to XML and JSON datatypes.
- YAML is a data serialisation language.
- Used to write the configuration files for k8s, Docker etc.

```yaml
"THIS IS A KEY": "THIS IS THE VALUE"
1: "VALUE"
#lists
- item1
- iteM1 # YAML is case sensetive.

cities:
 
- new delhi


line:>
this is a 
new line and will remain
a single line

booleanValue: No
bool : Yes
bools : FAlse
bool :y

setvaliableType : !!int 43
not a num : .nan
inf :!!float .inf


surname : !!null Null

~: "THIS IS A NULL KEY"

#advance datatypes:

student: !!seq
-marks
-name
-roll_no

#nested mappings

name : Kunal Kushwaha
role : 
	age:78
	job: student

name : kunal
role : {age : 78, job:student}


```