## Swift Syntax and Tips for Interviews

### Arrays

#### Create empty array
```
let intArr = [Int]()
let fullFormArray = Array<String>()
let shortFormArray = [String]()
```

#### Count frequency of each unique element in the array

```
var freqMap = [Int: Int]()
for num in nums { 
    freqMap[num, default: 0] += 1
}
```

#### Creating an array with values

```
let dogs: [String] = ["Dusty", "Teddy", "Pepe"]
print(dogs) // => ["Dusty", "Teddy", "Pepe"]
```

#### Array intializer
- Initialize an array by repeating the same value a particular number of times.
```
let helloEveryone = Array(repeating: "Hi", count: 3)
print(helloEveryone) // => ["Hi", "Hi", "Hi"]
```

```
let numbers = Array(0...3)
print(numbers) // => [0, 1, 2, 3]
```

#### Simple for loop
```
for i in (0 ..< nums.count) { 
    ...
}
```
#### Loop through an array with item and index
```
let array = ["Apples", "Peaches", "Plums"]

for (index, item) in array.enumerated() {
    print("Found \(item) at position \(index)")
}
```

### Sets
#### Create an empty set
```
let emptySet = Set<Int>()
```

#### Creating a set with values
```
let primeNumbers: Set = [2, 3, 5, 7, 11]
print(primeNumbers) // =>  [2, 3, 5, 7, 11]
```

```
let numbers = Set(1..<5)
print(numbers) // => [1, 2, 3, 4]
```

### Dictionary (unordered collection of key-value pairs)
#### Create an empty dictionary 
```
let empty = [String:Int]()
let fullFormDictionary = Dictionary<String, Int>()
let shortFormDictionary = [String: Int]()
```

### Others
#### Get type of value
```
let numbers = [1, 2, 3]
print(type(of: numbers))
```

#### Returns position of the first character of a given string
```
var low = s.startIndex
```

#### Returns position of the last character of a given string
```
var high = s.index(before: s.endIndex)
```

#### Returns position immediately after the given index
```
low = s.index(after: low)
```

#### Returns position immediately before the given index
```
high = s.index(before: high)
```

#### sort vs sorted()
- sort -> sort an existing mutable collection and don't need the original order anymore
- sorted() ->  it will give a copy of fresh sorted array and existing array will be in original state always

Resources:
- [Mastering Swift: Tips About Array and Dictionary Literals](https://dmitripavlutin.com/concise-initialization-of-collections-in-swift/)