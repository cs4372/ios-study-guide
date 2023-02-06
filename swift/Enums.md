## Enums (Enumerations)

- define a common type for a group of related values
- handy when you have a lot of different options you want to encode

### Syntax
```
enum SomeEnumeration {
    // enumeration definition goes here
}
```

#### Example for the four main points of a compass
```
enum CompassPoint {
    case north
    case south
    case east
    case west
}
```

#### Multiple cases can appear on a single line, separated by commas
```
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

#### Matching Enumeration Values with a Switch Statement
```
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```

#### Add default case when none of the cases is considered
```
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
```

#### Iterating over Enumeration Cases
```
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"
```

```
for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
```

### Associate values
- have values that you define attach to enums in each case in order to represent more meaningful data

E.g. We have an enum that defines the prices of Mercedes cars. Based on the price, we want to determine whether a user can afford the model of car or not. 

```
// enum with associated values
enum MercedesModelPrice {
   case MayBach(price: Int)
   case AMG_GT(price: Int)
   case Metris(price: Int)
   case SprinterWagon(price: Int)
   case GClass
}
```

Create a function to check whether a user can afford a Mercedes:
```
func getMercedesPrice(for mercedesModel: MercedesModelPrice) {
   switch mercedesModel {
   case .MayBach(price: let price) where price >= 100_000:
    print("You just bought yourself a new car")

   case .Metris(price: let price) where price >= 86_000:
    print("You just bought yourself a new car")

   case .AMG_GT(price: let price)  where price >= 74_000:
    print("You just bought yourself a new car")

   case .SprinterWagon(price: let price) where price >= 45_000:
     print("You just bought yourself a new car")

   case .GClass, .SprinterWagon, .Metris, .AMG_GT, .MayBach:
    print("Insufficient funds. You cant' afford this car at the moment")
```

### Enum values
- attaching a value to the enum case
- *Each raw value for our enum case must be a unique string, character, or value of any integer or floating-point type.*

```
enum Fruit: String {
    case Apple = "Red and crispy"
    case Orange = "Orange and you have to peel it"
    case Grape = "Purple and juicy"
    case Banana = "Yellow and monkeys eat it
}
```

Create a function that will return the rawValue of the fruits
func guessFruit(fruitName: Fruit) -> String {
    return fruitName.rawValue
} 

guessFruit(fruitName: .Apple)
guessFruit(fruitName: .Grape)

// expected output: 
// "Red and crispy"
// "Purple and juicy"
```

### Enum methods

- we can define methods in enums 

```
enum Weekday {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday

    func dayType() -> String {
        switch self {
        case .Sunday, .Saturday:
            return  "Weekend"
        default:
            return "Weekday"
        }
     }
}


Weekday.Monday.dayType()
// this will return "Weekday"
Weekday.Sunday.dayType()
// this will return "Weekend"
```

### Computed properties in Swift enums
```
enum Weekday {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday

    var dayType: String {
        self == .Saturday || self == .Sunday ? "Weekend" : "Weekday"
    }

}

Weekday.Monday.dayType
// this will return "Weekday"
Weekday.Sunday.dayType
// this will return "Weekend"
```