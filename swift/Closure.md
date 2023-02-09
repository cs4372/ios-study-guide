## Closure

- self-contained blocks of code that can be passed around and used in your code
- can capture and store references to any constants and variables from the context in which they're defined => known as closing over those constants and variables
- Swift handles all the of the memory management of capturing 

Functions are a type of closures. There are 3 closures:
- global functions -> have a name and cannot capture any values
- nested functions -> have a name and can capture values from their enclosing functions
- closure expressions -> don't have a name and can capture values from their context

### General Syntax
```
{ (parameters) -> return type in
statements
}

If the closure doesn't return any value, you can omit the arrow and return type

{ (parameters) in
statements
}
```

#### Examples:

1. Simple Closure (no parameters and returns nothing)
```
let sayHelloClosure = { 
    print("hello closure")
}
sayHelloClosure()
```

2. Closures which accepts a parameter and returns nothing
```
let sayHelloClosure: (String) -> () = { name in
    print("hello \(name)")
}
sayHelloClosure("Cat")
```

3. Closures which return a value
```
// closures that take two Int and return an Int
let addSumClosure: (Int, Int) -> Int = {a, b in
    a + b
}
print(addSumClosure(9,1))
```

More examples
```
var noParameterAndNoReturnValue = {
    print("Hello!")
}

var noParameterAndReturnValue = { () -> Int in
    return 1000
}

var oneParameterAndReturnValue = { (x: Int) -> Int in
    return x % 10
}

var multipleParametersAndReturnValue = 
    { (first: String, second: String) -> String in
    return first + " " + second
}
```

### Capturing Values

- closure that can capture values is a nested function, written within the body of another function
- A nested function can capture any of its outer function's arguments and can also capture any constants and variables defined within the outer function

E.g. The following function called  `makeIncrementer` contains a nested function called `incrementer`. `Incrementer` captures 2 values, `runningTotal` and `amount` from its surrounding context.
- After capturing these values, incrementer is returned by makeIncrementer as a closure that increments runningTotal by amount each time it’s called.

```
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

Resources:
- https://docs.swift.org/swift-book/LanguageGuide/Closures.html#
- https://github.com/codepath/ios_guides/wiki/Understanding-Swift#closures
- https://levelup.gitconnected.com/introduction-to-closures-in-swift-ea75477e8f0b
- https://medium.com/@anuj.rai2489/closure-vs-function-vs-protocol-in-swift-94d0ecd03406#:~:text=is%20the%20output-,Difference%20between%20Function%20and%20Closure,closure%20has%20in%20the%20keyword.
- https://www.weheartswift.com/closures/
- https://www.ecanarys.com/Blogs/ArticleID/342/Swift-Closures
