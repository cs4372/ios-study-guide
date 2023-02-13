## Inheritance

- A class can inherit methods, properties from another class. When one class inherits from another, the inheriting class is called a subclass, and the class inherits from is called a superclass. 

### Defining a Base Class

```
class Employee {
    var salary = 0.0
    var description: String {
        return "making \(salary) per year"
    }
    func work() {

    }
}
```

create a new instance of Employee
```
let someEmployee = Employee()
```

### Subclassing
- The subclass inherits characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass.

```
class SomeSubclass: SomeSuperclass {
    // subclass definition goes here
}
```
Example
```
class Teacher: Employee {
    var numOfStudents = 30
}
```

### Overriding

A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. 

```
class Teacher: Employee {
    override func work() {
        print("I don't go to work on weekends")
    }
}
```

### Preventing Overrides
- prevent a method, property, or subscript from being overridden by marking it as final

Resources:
- https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html