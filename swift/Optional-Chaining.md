## Optional Chaining

Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. 

? - optional chaining fails gracefully when the optional is nil
!- forced unwrapping triggers a runtime error when the optional is nil

A property that normally returns an Int will return an Int? when accessed through optional chaining.

Resources: 
- https://docs.swift.org/swift-book/LanguageGuide/OptionalChaining.html