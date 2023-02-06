## Collection Types

### 3 primary collection types:

1. Arrays - ordered collections of values
2. Sets - unordered collections of unique values
3. Dictionaries - unordered collections of key-value associations

You can mutate the collection if you create the types with a variable, but not with a constant.

### Arrays 
- stores values of the same type in an ordered list

#### Create an empty array
```
var someInts: [Int] = []
```
#### Creating an Array with a Default Value
```
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]

var threeDoubles = Array(repeating: 0.0, count: 3)
```

#### Creating an Array by Adding Two Arrays Together
```
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```

#### Iterating Over an Array
```
for item in cart {
    print(item)
}
```

```
for (index, value) in cart.enumerated() {
    print("Item \(index + 1): \(value)")
}
```

### Sets

#### Examples
```
var letters = Set<Character>()

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
```

### Dictionaries
```
var namesOfIntegers: [Int: String] = [:]
```

References:

- https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html