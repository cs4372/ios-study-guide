## Extensions

- Add functionality to a type, a class, a struct, an enum, or a protocol
- Can add new functionality to a type, but they can’t override existing functionality
- Add computed instance properties and computed type properties
- Provide new initializers
- Make an existing type conform to a protocol
- Can add computed propertise but  NOT stored properties

#### Extension Syntax
```
extension SomeType {
    // new functionality to add to SomeType goes here
}
```

### Add protocol conformance to make it adopt one or more protocols
```
extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
```

### Add new functionality to a type
- Can add computed instance properties and computed type properties to existing types. This example adds five computed instance properties to Swift’s built-in Double type, to provide basic support for working with distance units:

```
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"
```

### Add new initializers to existing types

- Can extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation

- Swift will create an initializer for us, init(title:pageCount:readingHours:), which we can use to instantiate an instance of the Book structure. 
- the initializer is no longer available if we define a custom initializer in the struct's definition.
Solution => create an extension for the Book struct in which we define the custom initializer.

```
Struct Book { 
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book { 
    init(title: String, pageCount: Int) { 
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount/50
    }
}

let catBook = Book(name: "Harry Potter", pageCount: 150, sleepingHours: 8)

````

Now, we can have the structure’s automatic memberwise initializer init(title:pageCount:readingHours) AND the custom intializer init(title: String, pageCount: Int)

Resources: 
- https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions#Initializers
- https://cocoacasts.com/four-clever-uses-of-swift-extensions
- https://medium.com/@nimjea/extensions-in-swift-d87d6ed0c6fd