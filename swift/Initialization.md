## Initialization 

Apple doc: Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.

#### Initializers
- Initializers are called to create a new instance of a particular type

```
init() { 
    // perform some initialization here
}
```

#### Set the initial value of a stored property from within an initializer

```
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}
```

#### Custom Initializers
```
class Person {
    var name: String
    var job: String
    init(name: String) {
        self.name = name
        self.job = "Engineer"
    }
    init(name: String, job: String) {
        self.name = name
        self.job = job
    }
}
// Call 
let eng1 = Person(name: "John")
let stud1 = Person(name: "Kevin", job: "Student")
```

#### Initializer Parameters Without Argument Labels
```
class Person {
    var name: String
    var job: String
    init(_ name: String, _ job: String) {
        self.name = name
        self.job = job
    }
}
// Call 
let eng1 = Person("Cat", "engineer")
```

Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value.
- Designated initializers
- Convenience initializers

Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up to the superclass chain. Every class should have at least one designated initializer.

```
init( __ INPUT PARAMETER __ ) {
        
}
```

Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

```
convenience init( __ INPUT PARAMETER __ ) {
        
}
```

```
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Cat")
    }
}
let dusty = Person(name: "Dusty")
print(dusty.name)
let cat = Person()
print(cat.name)
//Output
Cat
Dusty
```

Resources: 
- https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/
