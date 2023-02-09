## Var vs Const

### var
- value that can be changed at any time

```
var age = 15
print(age) // 15
age = 20 
print(age) // 20

```

### const 
- the value of a constant is immutable => it cannot be changed after assignment

```
let name = "Cat"
name = "Dusty" 
```

The code won't run.


### Assign consts and variables from other consts and variables. 

```
let defaultMiles = 50
var carOneMiles = defaultMiles  // 50
var carTwoMiles = defaultMiles  // 50

carOneMiles = 300
print(carOneMiles) // 200
```