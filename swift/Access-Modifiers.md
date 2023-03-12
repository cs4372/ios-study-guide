## Access Modifiers

### private vs fileprivate

- private => it can only be accessed within the enclosing type, e.g. a class and its extensions.
- fileprivate => is accessible anywhere in that file.

#### Private

- most restrictive access control level in Swift.

E.g. 

```
class Example {
    private var num: Int = 10
    func change() {
        // Works!
        self.num = 20
    }
}
extension Example {
    func changeAgain(){
        // Works!
        self.num = 30
    }
}
func show() {
    let e = Example()
    // Fails!
    print(e.num)
}
```

- `num` is private property. It can be updated in the class itself as well as in the extension to that class. `It cannot be accessed outside of the class.`


#### Fileprivate

- second most restrictive access control level in Swift.

```
class Example {
    fileprivate var num: Int = 10
    func change() {
        // Works!
        self.num = 20
    }
}
extension Example {
    func changeAgain(){
        // Works!
        self.num = 30
    }
}
func show() {
    let e = Example()
    // Works!
    print(e.num)
}
```

- `num` is accessible everywhere in the file. 
- If you put the show() function into a separate file, you are going to see an error. This is because num is not accessible outside the file where it is declared.

Resources:
- https://www.codingem.com/fileprivate-vs-private-swift/