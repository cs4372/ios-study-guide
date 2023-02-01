Classes and structs are the fundamental building blocks of Swift and we can use them to store data and model behavior. 

### They have many things in common:
- Define properties to store values 
- Define methods to provide functionality 
- Define initializers to set up their initial state
- Conform to protocols to provide standard functionality 

### Main Differences:
- Classes are `reference type` and Structs are `value type` objects
- Struct does not have inheritance and does not need to have init()

### Reference type: 
When we are initializing an object, RAM allocates memory space and address to it. Then, assigns its memory address to the object we created.

Reference types are not copied over when they are assigned to a variable or constant, of when they are passed to a function. Rather than a copy, a reference to the same existing instance is used.

In this example, we create a dog object and it is an instance of the Animal class with a name property. We create a cat object and assign dog to the cat object. Since a `class is a reference type`, cat object will point to the same memory address as the dog object. 

Both objects are pointing to the same memory address, so they are essentially the same object. If we change one of their properties, the property in the other object will also be affected because they are pointing to the same memory address.

```
class Animal {
	var name: String

	init(name: String) { 
		self.name = name
	}
}

var dog = Animal(name: "dog)
var cat = dog

print(dog.name) // prints "dog"
print(cat.name) // prints "dog"

dog.name = "hound"

print(cat.name) // prints "hound"
```

### Value type: 

Value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

=> You have an instance and you create a new copy and assign it to the first instance

=> It will have a new copy instead of referencing to the same memory as the 1st instance


```
struct Animal {
	var name: String

	init(name: String) { 
		self.name = name
	}
}

var dog = Animal(name: "dog)
var cat = dog

print(dog.name) // prints "dog"
print(cat.name) // prints "dog"

dog.name = "hound"

print(cat.name) // prints "dog"
```

### Which one to use?

According to the developer documentation..

#### Use structures by default.

#### Use classes when you need Objective-C interoperability.
- If we use an Objective-C API to process data, you might need to use classes and class inheritance to model your data because Objective-C doesn't have structs. For example, many Objective-C frameworks expose classes that you are expected to subclass.

#### Use classes when you need to control the identity of the data you’re modeling.
- If we read data from a remote database or external website, we don't control the data. So, we use a struct to prevent changing values in the database.

```
struct PenPalRecord {
    let myID: Int
    var myNickname: String
    var recommendedPenPalID: Int
}

var myRecord = try JSONDecoder().decode(PenPalRecord.self, from: jsonResponse)
```

#### Use Structures and Protocols to Model Inheritance and Share Behavior

- Structures and protocols can only adopt protocols; they can’t inherit from classes. We can use protocol inheriance and structures to build with class inheritance. 
- Start with protocol inheriance when we building an inheritance relationship from scratch, then adopt these protocols in your structures

```
// define the protocol
protocol Rotating {
    var rotates: Bool { get }
}

// give it a default implementation
extension Rotating {
    var rotates: Bool {
        return true
    }
}

// allow another struct or class to inherit
struct Fan: Rotating {}
let fan = Fan()
fan.rotates
```


References:
- https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
- https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes
- https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes
- https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/Structs-vs-Classes.md#use-classes-when-you-need-identity


