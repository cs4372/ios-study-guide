## Interview Questions

## Swift
- Questions about the Swift language itself.

#### Define Access Control
- Restricts access to parts of your code such as classes, methods, properties from the code in other source files and modules.
- Helps encapsulate your code and hides the implementation details of your code.
- In Swift 3 and 4, we have `open`, `public`, `internal`, `fileprivate` and `private` (least restrictive to most restrictive) for access control.

  <img src="https://github.com/cs4372/ios-study-guide/blob/master/interview-prep/swift-access-levels.png" height="300"/>

#### Private vs fileprivate
- private => it can only be accessed within the enclosing type, e.g. a class and its extensions.
- fileprivate => is accessible anywhere in that file.

#### Extensions vs Protocol extensions?
- Extensions -> add new functionality to an existing class, struct, enum, or protocol. Can only add implementations to existing members and cannot force conformance to protocols.
- Protocol Extensions -> provide default implementations for methods and properties defined in a protocol. Extend the behavior of existing types that conform to the protocol without modifying their original implementation.

#### What is a protocol?
- Defines a blueprint of methods and properties that guarantees certain behavior without specifiying 
the implementation of it 
- A class/struct/enum that adopts the protocol must implement all the required methods and properties defined in the protocol

#### What does the final keyword do? Why would you want to use it?
- To prevent a class, method, property, or subscript from being overriden or subclassed, so other classes cannot inherit from it or override its behavior. 
`Ensuring Immutability` - This feature is useful to enforce immutability and ensure that the behavior of a class remains unchanged and the implementation remains consistent across all subclasses.
`Improving Code Safety` - Codebase with fewer points of modifications so reduce the risk of introducing unexpected behavior when making changes.

#### [weak self] vs [unowned self]
- Both used to avoid retain cycles
- Retain cycles occur when 2 or more objects hold strong references to each other, causing them to remain in memory when they are no longer needed, leading to memory leaks.
- `[weak self]` -> used when you want to capture a weak reference to `self` inside a closure, so the closure does not keep a strong reference to `self`. If an object `self` is deallocated, the weak reference inside the closure will automatically become nil.
- `unowned self` -> used when you are sure that the closure will not outlive the object it captures (`self`). Unlike a weak reference, it always has a value and if the object `self` is deallocated when the closure is still in use, it will result in a runtime crash.
 `Always use [weak self] if there's a possibility of the closure outliving the captured object.`

#### Property observers
- allow us to observe and response to changes in a property's value
- 2 types of property observers:`willSet` and `didSet`
- `willSet` is called before the valueof the property is about to be changed and `didSet` is called immediately after the value of the property has been changed
- Common usecase: updating UI elements when a property changes. E.g. if you have a score property that holds an integer, you might attach a didSet observer so that it updates a label whenever the score changes.

#### If let vs guard let?
- Both check and unwrap optionals, but `guard` provides an early exit if its check fails and variables `guard` unwraps stay in scope after the `guard` block
- Unwrapped variables in `if let` are only available within the scope of the `if` block.

#### Optional binding
- To find out whether an optional contains a value. If so, make that value available as a temporary constant/variable.
```
if let constantName = someOptional { 
    .. do something
}
```

#### What is `Intialization` in swift?
- Process of preparing an instance of a class, struct, or enum for use by setting its initial state and allocating memory.

#### Escaping closure and a non-escaping closure
- An escaping closure can outlive the function it is passed to and is commonly used for asynchronous operations or when you need to store the closure for later execution. 
- A non-escaping closure is executed within the function's context and doesn't outlive the function. It's more efficient and typically used for synchronous operations or immediate execution within the function.
- Swift uses non-escaping closures by default – they remove a small performance hit caused by Swift needing to keep escaping closures alive in memory after the function finishes.

#### Explain Enum and associated value?
- Enum is a special data type that allows you to define a group of related values and come in handy when you have a lot of different options you want to encode.
```
enum Direction {
    case up
    case down
    case left
    case right
}
```
- Associated values in enums allow you to associate additional data with each enum case. 
- This is useful when you want to store additional information related to a specific case.
```
enum MercedesModelPrice {
   case MayBach(price: Int)
   case AMG_GT(price: Int)
   case Metris(price: Int)
   case SprinterWagon(price: Int)
   case GClass
}
```

#### Value type vs Reference type?
Value type:
- Values stored directly in memory.
- Copies are independent of each other.
- Copies allow safe and independent mutation.
- Automatic memory management (no retain cycles).
- E.g. Integers, floats, enums, structs, tuples.

Reference type:
- References (memory addresses) stored in memory.
- Copies share the same underlying data.
- Changes in one reference affect all references.
- Requires careful memory management to avoid retain cycles and leaks.
- E.g. Classes, closures.

#### == vs ===?
- == operator checks if the `values` are the same, comparing value types. `"equal to"`
- === operator checks if the `references` point to the same instances (both point to the same memory address) `"identical to"`

#### as? vs as! (used for type casting)
- as? (Conditional downcasting) -> Returns an optional value of the type you are trying to downcast to.
- as! (Forced downcasting) -> Only use when you are sure that the downcast will always succeed, otherwise will result in a runtime error.

#### What's a Typealias?
- Allows you to provide a new name for an existing data type into your program
- Do not create new types, simply provide a new name to an existing type
- Purpose is to make code more readable

E.g.
```
class Student {

}
var students:Array<Student> = [] // without type alias
typealias Students = Array<Student>
var students:Students = []
```

## iOS
#### viewDidLoad and viewWillAppear?
viewDidLoad: 
- Called when controller's view is loaded into memory
- Gets called only `once` in the initial load
- Great for initial setup and one-time setup tasks like initializing variables, setting up UI elements, or loading data.

viewWillAppear: 
- Called just before the view controller's view is about to be added to the view hierarchy and become visible on the screen
- Called every time the view is about to appear on the screen and when it navigates back and forth between view controllers. e.g. refreshing data or updating UI elements based on the latest state. 

#### How would you round the corners of one of your views?
- Set the corner radius to round the corners
```
view.layer.cornerRadius = 20
```
Set `view.clipsToBounds` to true to ensure that any subviews inside view are clipped to its rounded bounds.

## UIKit
- Questions about building apps with UIKit.

#### How are XIBs different from storyboards?
- Both are used for creating user interfaces
- `Xibs` -> used for individual UI elements / small reusable components e.g. custom views / table view cells. Are standalone files and it offers a more modular approach.
- `Storyboards` -> manage the entire app's user interface and navigation flow. They contain multiple view controllers and their interfaces in a single file.

#### What are Storyboard identifiers?
- Used to uniquely identify view controllers in a storyboard file, so that we ccan create an instance of it. Unless a view controller is marked as the initial view controller, giving it an identifer is the only way to reference it in code.

#### What is the purpose of reuse identifiers for table view cells?
- To efficiently manage and reuse the cells as the user scrolls through a table view.
- When we create a table view, it often contains a large number of cells, and creating a new cell for each row can be inefficient and consume a lot of memory.
- When a cell goes off-screen, it is saved in a reuse pool and can be reused for new rows with the same identifier, therefore reducing memory usage and enhancing the performance of table views.
- `Downside` is that Reusing cells can result in incorrect content display, performance overhead (if cells are highly customized / reuse pool becomes excessively large)

## Performance
- Questions about improving your apps to be faster, more efficient, less crashy, and similar.

