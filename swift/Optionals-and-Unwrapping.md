#### Optionals and Unwrapping

## What is an optional?

- signifies either a wrapped value or nil
- can contain nil values and there are multiple ways to unwrap them.
- are assumed to contain a value. Therefore whenever you access an implicitly unwrapped optional, it will automatically be force unwrapped for you. If it doesn’t contain a value, it will crash.
  
```
var x: Int? = 3 // type is NOT Int, it's optional INT
```
## 3 ways to unwrap an Optional:

Forced Unwrapping
Implicit Unwrapping
Optional Binding (Recommended)

### Forced Unwrapping (Not recommended unless you know 100% value is NOT nil)

- extracts the value of the optional variable.
a- will crash if value is nil

```
var name: String? = "Dusty"
var age: Int? = nil
print(name!) //Prints Dusty
print(age!) //Leads to runtime error since age is set to nil
```

### Implicit Unwrapping

- similar to optionals since they’re allowed to have nil value but they do not need to be checked before accessing
- Swift force unwraps the value every time
- will crash if value is nil

```
Defining an implicitly unwrapped optional
var name: String!
```

- Implicitly unwrapped optionals are mainly used for convenience when the value once initialised is never nil. Apple uses it for outlets. 

### Optional Binding

Use optional binding control structures like `if let` and `guard let` to safely unwrap the value of an Optional.

```
var name: String?
if let name = name {
	//Perform actions on the variable name
}
guard let name = name else {
	//Handle case where name name is nil
}
```

Swift 5.7's new optional unwrapping syntax
- we can drop the assignment after if let statement 
```
if let x { 
	..... perform updates
}
```

### guard let vs if let 

### if let 
- values unwrapped using if let are accessible in the if block only. It doesn’t require a return statement.

### guard let

1. simple way to replace if else statements 
2. for unwrapping optionals (popular)

- exit the current function, loop, or scope if the check fails so any values you unwrap using it will stay around after the check

```
var text: String?
   text = "hello world"
		
		if let value = text { 
				print(value
		}

		guard let value = text else { return }
		print(value)
```
