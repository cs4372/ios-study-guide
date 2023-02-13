## Type Casting

- Type casting in Swift is implemented with the is and as operators. 
- `is` is used to check the type of a value 
- `as` is used to cast a value to a different type.

Difference between as? and as!
- Conditional downcasting (as?)
- Forced downcasting (as!).

Use the conditional form of the type cast operator (as?) when you are not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.

Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.

Resources: 
- https://abhimuralidharan.medium.com/typecastinginswift-1bafacd39c99