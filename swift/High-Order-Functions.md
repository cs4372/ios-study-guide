## High Order Functions

```
struct Product {
    let name: String
    let price: Double
    let quantity: Int
}

let store = [Product(name: "Nemo", price: 3.20, quantity: 2),
             Product(name: "Mickey", price: 2.50, quantity: 6),
             Product(name: "Teddy", price: 6.80, quantity: 2),
             Product(name: "Dusty", price: 5.85, quantity: 7)
]
```

### Filter
- takes a closure as an argument and inside the closure, $0 refers to each individual element (product) in the store array
  
```
let cheapProducts = store.filter { $0.price < 5.00 }
print(cheapProducts)
```

### Map
- transforms elements in a collection
```
let productNames = store.map { $0.name }.sorted()
let increasedPrices = store.map { $0.price * 2.5 }
print(productNames)
print(increasedPrices)
```

### Reduce
- combine all elements of a collection into a single value
- It takes two arguments: an initial value (0 in this case) and a closure that defines the accumulation logic.
- Inside the closure, $0 represents the accumulated value, and $1 represents each individual element (product) in the store array.
- The closure expression { $0 + $1.price } adds the price of each product ($1.price) to the accumulated value ($0).
```
let nums = [1,4,6,8,9,25]
let sum = nums.reduce(0,+)
print(sum)

let sumPrices = store.reduce(0, { $0 + $1.price})
print(sumPrices)
```

### Chaining
```
let totalRevenue = store.map { $0.price * Double($0.quantity) }.reduce(0,+)
print(totalRevenue)
```

### Compact Map
-  filters out the nils
```
let nilNumbers: [Int?] = [1, nil, 17, nil, 3, 7, nil, 99]
let nonNilNumbers = nilNumbers.compactMap{ $0 }
print(nonNilNumbers)
```

### Flat Map
```
let arrayOfArrays: [[Int]] = [[1,2,3],
                              [4,5,6],
                              [7,8,9]]
let singleArray = arrayOfArrays.flatMap{ $0.map { $0 * 2 }}
print(singleArray)
```