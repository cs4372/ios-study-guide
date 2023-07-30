## Interview Questions

### Swift
- Questions about the Swift language itself

#### Define Access Control
- restricts access to parts of your code such as classes, methods, properties from the code in other source files and modules.
- helps encapsulate your code and hides the implementation details of your code.
- in Swift 3 and 4, we have `open`, `public`, `internal`, `fileprivate` and `private` (least restrictive to most restrictive) for access control.

#### Private vs fileprivate
- private => it can only be accessed within the enclosing type, e.g. a class and its extensions.
- fileprivate => is accessible anywhere in that file.

#### Extensions vs Protocol extensions?
- Extensions -> add new functionality to an existing class, struct, enum, or protocol. Can only add implementations to existing members and cannot force conformance to protocols.
- Protocol Extensions -> provide default implementations for methods and properties defined in a protocol. Extend the behavior of existing types that conform to the protocol without modifying their original implementation.