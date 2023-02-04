#### Error Handling

- process of responding to error conditions in your program

Suppose if the password we entered was too sort, or if a file that we wanted to read doesn't exist, or even when that data you tried to download failed because the network was down. If we didn't handle the errors graceful, our program would crash. Below is a summary of how to handle and respond to errors.

## How to throw an error
1. Make a list of the possible errors using `Enum` you want to throw
2. Create a throwing function using `throws`
3. Call the function using the `try` keyword and wrap the code with try in the `do {...}` block and add the `catch {...}` block to handle all errors.

4. Create enum of Errors
- create an enum that represents the type of errors we may encounter 
- enum must conform to the `Error` protocol 

```
enum ErrorsToThrow: Error {
    case fileNotFound
    case fileNotReadable
    case fileSizeIsTooHigh
}
```

2. Create a function that can throw errors by adding throws at the end of the function parameter. It just throws an error which will be caught and handled in a seperate block with do-try.

```
func readFiles(path:String) throws -> String {
    if fileNotFound {
        throw ErrorsToThrow.fileNotFound
    } else if fileNotReadable {
        throw ErrorsToThrow.fileNotReadable
    } else if fileSizeIsTooHigh {
        throw ErrorsToThrow.fileSizeIsTooHigh
        }
    return “Data from file”
}
```

3. Call function using try, catch wrapped in a do block 

```
do {
    let dataFromString = try? readFiles(path: “path for file”)
    } catch ErrorsToThrow.fileNotFound {
    print(“fileNotFound”)
} catch ErrorsToThrow.fileNotReadable {
    print(“fileNotReadable”)
    } catch ErrorsToThrow.fileSizeIsTooHigh {
    print(“fileSizeIsTooHigh”)
}
```

If there is no error throw, the `catch` block is ignored

## try vs try! vs try?

- try is only used within a do-catch block. 
However, try? and try! can be used without it.

- try? returns an optional type. 
It can be used without a do-catch block. 
If the method of initializer throws an error, the result will be nil.

```
let file = try? readFiles(path: project/example”)
let file1 = try? readFiles(name: nil) // nil (file1 is an optional which can handle nil)

```

- try! It returns a normal type. If the method/init throws an error, it will crash. Because the returned type will be nil and a normal type cannot handle nil.

Avoid using! in most cases since it will break your program.

References:
1. https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
2. https://www.programiz.com/swift-programming/error-handling
3. https://abhimuralidharan.medium.com/error-handling-in-swift-d0a618499910