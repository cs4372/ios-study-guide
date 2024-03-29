## Closure

- self-contained blocks of code that can be passed around and used in your code.
- can capture values and constants from the enclosing scope -> allows functions and closures to retain and use variables and constants defined in their surrounding context, even after that context has exited.
- Swift handles all of the memory management of capturing
- *Note*: Functions can capture values within the enclosing scope too but closures offer a more concise syntax and its primary focus is to capture context.

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

E.g. The following function called  `makeIncrementer` contains a closure called `incrementer`. `Incrementer` captures 2 values, `runningTotal` and `amount` from its surrounding context (body of the makeIncrementer function).
- After capturing these values, incrementer is returned by makeIncrementer as a closure that increments runningTotal by amount each time it’s called.
- When you create an instance of the incrementer closure using makeIncrementer(amount: 2), it captures the amount you provided (2 in this case) and starts incrementing the total by 2 each time it's called.

```
func makeIncrementer(amount: Int) -> () -> Int {
    var runningTotal = 0
    func increment() -> Int { 
        runningTotal += amount
        return runningTotal
    }
    return increment
}

let incrementByTwo = makeIncrementer(amount: 2)
print(incrementByTwo())  // Output: 2
print(incrementByTwo())  // Output: 4
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
greet() function takes a callback function, completion. greet() function calls the completion handler right after it has printed “Hello world!” into the console. This executes the completion handler we pass into the greet() function call.

Callbacks are useful in Swift when dealing with asynchronous tasks.

Example: Make an HTTP request that retrieves the HTML content of StackOverflow’s front page. As this request takes a while, we need a callback function that shows the HTML content once the HTTP request completes.

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

## Escaping Closures

- An escaping closure is a closure that outlives the function it is passed to.
This means the closure can be executed after the function that received it has finished its execution, possibly when the calling scope has already returned.
- Escaping closures are typically used when you need to perform some asynchronous operation or store the closure for later execution.
- For example, if you pass a closure as a completion handler to a network request function and that closure is executed after the network request completes, it needs to be marked as escaping.
- By marking the closure as `@escaping`, the function ensures that the closure is not deallocated when it returns, and can be executed later when the asynchronous operation completes.
-  In summary, the `@escaping` attribute is required to ensure that the closure is still available for execution when the delayed block / function executes because it allows the closure to outlive the function that it's passed into and be captured and executed by the delayed block.

## Examples

```
class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!

    func getData() { 
        // it's fine to deinitialize the class, we don't need it to be alive
        downloadData4 { [weak self] (returnedData) in 
            self?.textLabel = returnedData.data
        }
    }

    func downloadData() -> String { 
        return "New data!"
    }

    func downloadData2(completionHandler: DownloadCompletion) { 
        completionHandler("New data!")
    }

    // Not going to immediately execute and return
    func downloadData3(completionHandler: @escaping DownloadCompletion) { 
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New data!")
        }
    }

    func downloadData4(completionHandler: @escaping DownloadCompletion) { 
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }}

struct DownloadResult { 
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()
```

#### Perform a network requst
- One place is in completion handlers when downloading data/images. Completion handlers are closures. The closure isn’t called immediately. So after we’re done downloading successfullly, then we call the closure to handle the data that we got.

```
func fetchData(_ completion: @escaping (_ success: Bool, _ data: Data?) -> Void) {
    
   // Build an URL
   let url = URL(string: "sample_url")!
    
   // Perform the network request
   let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
         // Success, call the completion handler with the data
         completion(true, data)
      } else {
         // Failure, call the completion handler with nil data
         completion(false, nil)
      }
   }
   task.resume()
}

self.fetchData { success, data in
   if success {        
      guard let dataObject = data else { return }
        
      // Parse the data and update the UI
      let json = try? JSONSerialization.jsonObject(with: dataObject)
      print(json!)        
   } else {
      // Show an error message
      print("Network request failed")
   }
}
```

- If we don't mark the closure as @escaping, it means that the closure should be used immediately, right where it is defined, before we even get the data from the network request
- When we make a network request to fetch data, it takes some time for the data to arrive. So, marking the closure as @escaping ensures that it waits patiently for the data to arrive before running, allowing us to handle the fetched data correctly in our program


#### Delay example
- The delayedPrint function finishes executing as soon as it schedules the closure to be executed after the specified delay. The function itself doesn't wait for the delay to complete or for the closure to execute.
- Using escaping closure in this example is necessary to handle the scenario where the closure is executed after the function call has completed.

```
func delayedPrint(message: String, after seconds: Double, completion: () -> Void) {
    print("Waiting for \(seconds) seconds...")
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        print(message)
        completion()
    }
}

// This will result in a compilation error
delayedPrint(message: "Delayed message", after: 3.0) {
    print("Closure executed after delay")
}

print("Function call completed")
```


Resources:
- https://docs.swift.org/swift-book/LanguageGuide/Closures.html#
- https://github.com/codepath/ios_guides/wiki/Understanding-Swift#closures
- https://levelup.gitconnected.com/introduction-to-closures-in-swift-ea75477e8f0b
- https://medium.com/@anuj.rai2489/closure-vs-function-vs-protocol-in-swift-94d0ecd03406#:~:text=is%20the%20output-,Difference%20between%20Function%20and%20Closure,closure%20has%20in%20the%20keyword.
- https://www.weheartswift.com/closures/
- https://www.ecanarys.com/Blogs/ArticleID/342/Swift-Closures
- https://www.codingem.com/swift-completion-handlers/
- [How to use escaping closures in Swift](https://www.youtube.com/watch?v=7gg8iBH2fg4&t=506s)
- [What is a completion handler](https://www.tutorialspoint.com/what-is-a-completion-handler-in-swift)
- [You don’t (always) need [weak self]](https://medium.com/@almalehdev/you-dont-always-need-weak-self-a778bec505ef)
