## Singleton

- singleton pattern ensures that only one instance of a class is instantiated and the entire application only uses that instance

Examples of singletons:

```
// Shared URL Session
let sharedURLSession = URLSession.shared

// Default File Manager
let defaultFileManager = FileManager.default

// Standard User Defaults
let standardUserDefaults = UserDefaults.standard

// Default Payment Queue
let defaultPaymentQueue = SKPaymentQueue.default()
```

### How to create a singleton

```
class MySingleton {
    static let shared = MySingleton()
    
    private init() {}
    
    // Other methods and properties go here...
}
```

MySingleton class has a shared instance called shared that can be accessed from anywhere in the application. The private init() method ensures that no other instances of the MySingleton class can be created outside of the shared property. This way, the shared instance will be the only instance of the MySingleton class that can be used in the application.

#### Pros
- Provide a single, shared instance of a class that can be accessed throughout an application.

#### Cons
- Can create tight coupling and dependencies between classes, making it harder to test and maintain code.
