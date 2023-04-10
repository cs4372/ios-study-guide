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

#### Convenience initializers
- are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

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

#### Failable Initializer

- In some cases, some intializers may or may not work. 
- We place a question mark (?) after the init keyword and return nil if something goes wrong. For example,

```
class File {

  var folder: String

  // failable initializer
  init?(folder: String) {

    // check if empty
    if folder.isEmpty {
      print("Folder Not Found") // 1st output
      return nil
    }
    self.folder = folder
  }
}

// create folder1 object
var file  = File(folder: "")
if (file != nil) {
  print("File Found Successfully")
}
else {
  print("Error Finding File") // 2nd output
}
```

#### Required initializer
- If you mark an initializer required in your class, you have to mark as required in every level - subclasses of that class have to implement it too.

```
class Point {
    let x: Int
    let y: Int

    required init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class NamedPoint: Point {
    let label: String?

    required init(x: Int, y: Int) {
        self.label = nil

        super.init(x: x, y: y)
    }
}

let p1 = NamedPoint(x: 1, y: 1)
```

`required init`

```
required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}
```
This code is needed to make sure that all of the inherited properties and setup code from its superclass is properly initialized as well, like when it's loaded from a storyboard or a nib file. 

Nib file: binary file format used by Apple's Interface Builder application to store graphical user interface (GUI) designs. It contains information about the UI elements, their layout, etc. When the app is built, the nib file is compiled into a format that can be loaded and displayed by the app.

Resources: 
- https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/
- https://theswiftdev.com/swift-init-patterns/ 
- https://www.programiz.com/swift-programming/initializer
