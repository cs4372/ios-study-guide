## Dependency Injection

- Design pattern in software development where the dependencies (external objects or services that a class or module relies on) are provided from the outside, rather than being created or managed within the class itself.
- Promotes loose coupling between components and enhances modularity and testability

#### Benefits:
- Modularity: Components focus on their specific tasks and don't need to know about the creation of their dependencies. This promotes seperation of concerns.
- Testability: You can easily replace real dependencies with mock objects for unit testing., isolating the component under test.
- Flexibility: Changing dependencies becomes easier without modifying existing code.
Decoupling: Components become less tightly coupled because they depend on abstractions (usually protocols) rather than concrete implementations.

E.g 

```
// Dependency: NetworkManager
class NetworkManager {
    func fetchData(completion: @escaping (Data) -> Void) {
        // Simulate fetching data from a network
        // ...
    }
}

// Service that requires a NetworkManager
class UserService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchUserData(completion: @escaping (UserData) -> Void) {
        networkManager.fetchData { data in
            // Parse data into UserData and call completion
            // ...
        }
    }
}
```

Examples of Dependency Injection:

1. Constructor Injection: passing dependencies through the initializer of a class.
```
let networkManager = NetworkManager()
let userService = UserService(networkManager: networkManager)
```

2. Property Injection: setting dependencies as properties after the object is created.
```
let userService = UserService()
userService.networkManager = networkManager
```

3. Method Injection: passing dependencies as parameters when calling a method.
```
func processUserData(using networkManager: NetworkManager) {
    // ...
}

processUserData(using: networkManager)
```
