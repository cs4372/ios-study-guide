## Closure

- self-contained blocks of code that can be passed around and used in your code
- can capture and store references to any constants and variables from the context in which they're defined => known as closing over those constants and variables
- Swift handles all of the memory management of capturing 

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

4. Closure as a parameter to a function

The closure block is not executed as we have not called the closure.

```
func sayHello(closure:()->()) {
 
    print("sayHello is Called")
}
 
sayHello(closure: {
    print("This is closure") // closure parameter
})
 
//OUTPUT :-
sayHello is Called
```

```
func sayHello(closure:()->()) {
 
    print("sayHello is Called")
    closure()
}
 
sayHello(closure: {
    print("This is closure")
})
 
//OUTPUT :-
sayHello is Called
This is closure
```

5. Trailing Closure - When the function uses the closure as the last parameter

```
func sayHello(msg: String, closure:()->()) {
    print(msg)
    closure()
}
 
sayHello(msg:"Hello")  {
    print("World")  //closure parameter
}
 
//OUTPUT :-
Hello
World
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
- After capturing these values, incrementer is returned by makeIncrementer as a closure that increments runningTotal by amount each time it???s called.

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

### Use of Closures

1. Closures can be passed an an input parameter and they can more readable than a function.
2. Completion Handler to notifiy us that certain work has been completed

Example (Not useful):
```
func greet(_ completion: () -> ()) {
    print("Hello world!")
    completion()
}
greet({
  print("Task finished.")
})
```
Output:
```
Hello world!
Task finished.
```
greet() function takes a callback function, completion. greet() function calls the completion handler right after it has printed ???Hello world!??? into the console. This executes the completion handler we pass into the greet() function call.

Callbacks are useful in Swift when dealing with asynchronous tasks.

Example: Make an HTTP request that retrieves the HTML content of StackOverflow???s front page. As this request takes a while, we need a callback function that shows the HTML content once the HTTP request completes.

```
let url = URL(string: "http://www.stackoverflow.com")!
let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
    // Check if there is any HTML data
    guard let data = data else { return }
    // Make the HTML data readable
    let HTMLContent = String(data: data, encoding: .utf8)!
    // Show the HTML data
    print(HTMLContent)
})
task.resume()
```

Resources:
- https://docs.swift.org/swift-book/LanguageGuide/Closures.html#
- https://github.com/codepath/ios_guides/wiki/Understanding-Swift#closures
- https://levelup.gitconnected.com/introduction-to-closures-in-swift-ea75477e8f0b
- https://medium.com/@anuj.rai2489/closure-vs-function-vs-protocol-in-swift-94d0ecd03406#:~:text=is%20the%20output-,Difference%20between%20Function%20and%20Closure,closure%20has%20in%20the%20keyword.
- https://www.weheartswift.com/closures/
- https://www.ecanarys.com/Blogs/ArticleID/342/Swift-Closures
- https://www.codingem.com/swift-completion-handlers/
