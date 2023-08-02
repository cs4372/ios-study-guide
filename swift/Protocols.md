## Protocols

- define a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality
- can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements and it has to conform to the protocol
- similar to an interface in other languages

### Protocol Syntax

```
protocol SomeProtocol {
    // protocol definition goes here
}
```

#### Multiple protocols can be listed, and are separated by commas:
```
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}
```

#### If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma:
```
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}
```

### Requirements

- can have properties as well as methods that a class, enum or struct conforming to this protocol can implement.
- doesn’t specify whether the property should be a stored property or a computed property — it only specifies the required property name and type
- pecifies whether each property must be gettable OR gettable and settable.
- Property requirements are always declared as variable properties, prefixed with the var keyword.

```
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
```

#### Conforming to a protocol Example
```
protocol FullNamed { 
    var fullName: String { get } // gettable stored property
}
// this struct conforms to the FullyNamed protocol
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
```
We can also define the fullName proprety as a computed property
```
struct Person: FullyNamed { 
    var fullName: String { 
        return "Cat S"
    }
}
let cat = Person()
cat.fullName
```

### Protocols with mutating methods

- Mutating methods are ones that we use on value types like structs and enums. They are allowed to modifiy the instance it belongs and any properties of that instance. E.g

```
struct Square { 
    var width = 1
    var height = 1

    func area() => Int { 
        return width * height
    }

    mutating func scaleBy(value: Int) { 
        width *= value
        height *= value // modifies values so function should be marked as mutating
    }
}
```

### Initializer Requirements
- Protocols can require specific initializers to be implemented by conforming types

```
protocol SomeProtocol { 
    init(someParameter: int)
}
```

#### Class Implementations of Protocol Initializer Requirements
```
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
```

Resources:
- https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols#Method-Requirements
- https://abhimuralidharan.medium.com/all-about-protocols-in-swift-11a72d6ea354