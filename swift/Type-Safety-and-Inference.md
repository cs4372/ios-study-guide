## Type Safety and Type Inference

### Type Safety

- Swift is a type-safe language
- encourages developers to be clear about the types of values your code can work with
E.g. if the code expects an Int, you can't pass it a Double or a String.
- Swift performs `type checking` on all your constants and variables and flags mismatched errors as errors when compiling your code. 

```
let name = "Cat"
var age = 20
age = name
```

The code will not compile due to mismatched types. 

### Type Inference

- Swift uses type inference to make assumptions about the type based on the value assigned to the constant or variable. Hence, we don't have to specifiy the type of value when we declare a constant/variable. 

```
let country = "Japan"
// Japan is a string so compiler automatically assigns the type to a "String"
```

### 3 common cases for using type annotation

1. When you create a constant/variable but haven't yet assigned it a value

```
let country: String
....
country = "Brazil"
```

2. When you create a constant/variable that could be inferred as more than one type.

```
var percentage: Double = 80
// 80 would be inferred as an Int but the variable could support decimal numbers as well
```

3. When you write your own type definition

```
struct Person { 
    var name: String
    var age: Int
    var location: String
}

Resources:
- Develop in Swift Fundamentals e-book