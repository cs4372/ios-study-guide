## Methods

## Mutating Keyword

In order to modify the properties of a value type, you have to use the mutating keyword in the instance method.

```
struct person {
    var name: String

    mutating func changeName() {
        name = "Cat
   }
}

var person = Person(name: "Dusty")
person.changeName()  // Cat
```