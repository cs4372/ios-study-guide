## Swift Syntax and Tips for Interviews

#### Loop through an array with item and index
```
let array = ["Apples", "Peaches", "Plums"]

for (index, item) in array.enumerated() {
    print("Found \(item) at position \(index)")
}
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