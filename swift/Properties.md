## Properties

### Stored Properties 
- a constant/variable that stores value for an instance of a particular class/structure

```
class Person {

 // define two properties
 var name: String = ""
 var age: Int = 0
}

var person1 = Person()

// assign values to properties
person1.name = "Car"
person1.age = 20

// access properties
print("Name:", person1.name)
print("Age:", person1.age)
```


### Computed Properties

- do not store a value, but computes the value
- provider a getter and an optional setter to retrieve and set other properties and values indirectly

```
class Calculator {

  // define two stored properties
  var num1: Int = 0
  var num2: Int = 0

  // define one computed property
  var sum: Int {

    // calculate value
    num1 + num2
  }
}

var obj = Calculator()
obj.num1 = 11
obj.num2 = 12

// access the computed value by accessing the computed property
print("Sum:", obj.sum)
```

#### Getters and Setters for Computed Properties

- getter - returns the computed value
- setter - changes the value

```
class Calculator {
  var num1: Int = 0
  var num2: Int = 0

  // create computed property
  var sum: Int {

    // retrieve value
    get {
      num1 + num2
    }
  
    // set new value to num1 and num2
    set(modify) {
      num1 = (modify + 10)
      num2 = (modify + 20)
    }
  }
}

var obj = Calculator()
obj.num1 = 20
obj.num2 = 50

// get value
print("Get value:", obj.sum) // 70

// provide value to modify
obj.sum = 5

print("New num1 value:", obj.num1) //15
print("New num2 value:", obj.num2) // 25
```

### Property Observers 

2 types:
- willSet is called just before the value is stored.
- didSet is called immediately after the new value is stored.
- willSet has default value associated with name "newValue"
- didSet has default value associated with "oldValue"

E.g. 
```
var price: Int = 0 {
    willSet {
        print("newValue: \(newValue), current value: \(price)")
    }
    didSet {
        print("oldValue: \(oldValue), current value: \(price)")
    }
}

price = 50
```

Console
```
newValue: 50, current Value: 0
oldValue: 0, current value: 50
```

The value is stored once `didSet` is executed

### Lazy stored property

- initial value is not calculated until the first time it is called/used.
- wil be initialized once it is called/used
- You indicate a lazy stored property by writing the lazy modifier before its declaration.
- be declared as variables with the var keyword, not constants. 
- Constant properties must always have a value before the initialization completes, and therefore can’t be declared lazy.

Resources:
- https://www.programiz.com/swift-programming/properties