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