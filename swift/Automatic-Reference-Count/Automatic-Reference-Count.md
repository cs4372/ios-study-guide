## Automatic Reference Count (ARC)

- Swift uses ARC to track and manage your app's memory usage
- keeps track of classes instances and decides when it is safe to deallocate the class instances it monitors. It does this by counting the references of each class instance.
- Reference counting applies only to instances of classes. ARC does not increase or decrease the reference count for values types, like struct or enum, because they are copied when assigned. 

### Functions of ARC

- 2 methods of memory management: initialization `init()` and deinitialization `deinit()`. 
1. init() creates new classes and ARC allocates a block of memory to keep the information in the new classes 
2. When the class instance is used up, the `deinit()` function frees up memory for future class instance 
3. To prevent deallocation of classes once class instance is running, ARC keeps a `strong reference` to such class instance properties, constants and variables 

### How ARC works

- ARC allocates a portion of memory space to hold data on a new instance of a clas whenever one is created
- When an instance becomes obsolate, ARC releases the space utilized by that instances, allowing it to be used for other purposes to prevent instances from taking up memory when they are no longer required. 

#### Example of how ARC works 

```
class Person {
    let salary: String
    init(salary: String) {
        self.salary = salary
        print("\(salary) is being initialized")
    }
    deinit {
        print("\(salary) is being deinitialized")
    }
}

var cat : Person? = Person(salary: "200")
cat = nil   

We construct an example of class Person named cat and provide all of the class’s data to it. By doing so, it gives cat a strong reference to the object.
```

- An initializer in the Person class creates the instance’s salary property and produces a signal to indicate that initialization is in progress. 
- When an instance of the Person class is deallocated, it has a deinitializer that outputs a message for the deallocation operation.
- ARC memory management does not deallocate any objects with strong references. Next, we nil the reference to the object cat, which deallocates the object it was referencing; this is how the deinit() function of the class Person is called before it deallocates the object.

### Reference/Retain cycles
- occur when there are two strong references pointing to each other This causes the instances of both of these variables to remain alive even though they ideally shouldn’t
- Setting one of them to weak will allow ARC to get to zero.
- There are three types of reference cycles in ARC; strong, weak, and unowned references

### Strong Reference Cycle 
- A strong reference is an object whose deallocation is not done by ARC
- The retain cycle is when two classes depend on each other, so we cannot release any of them

### Breaking a strong reference cycle
- The use of weak and unowned references.

### Weak references cycles
- does not maintain a strong hold on the object it refers to
- A weak reference does not increment the reference count, and it automatically becomes nil when the object it refers to is deallocated

### weak self vs unowned self (both break strong reference cycles and avoid memory leaks)
#### weak self
-  it creates an optional weak reference to the object. The reference can become nil if the object is deallocated, meaning it handles the case where the object might not exist anymore

Example:

You have a view controller and it shows the user profile with their information and images. The closure is used to fetch the user's informaton and whhile the closure is fetching the data, the user might leave the screen and navigate to another screen. What that happens, the VC is not needed anymore as the user is not on the same screen. The closure will continue to fetch the data and this can create a retain cycle where they both hold on tightly, causing memory leaks. Using [weak self] in the closure gently lets go of the view controller when not needed, avoiding memory issues and ensuring a smooth app experience.

#### unowned self
- are non-optional and assume that the object will always exist when the closure is called. If the object is deallocated before the closure is executed, it can lead to a runtime crash if you try to access the unowned reference

### Example
from [Retain Cycle, Automatic Reference Counting, Memory Leak](https://www.youtube.com/watch?v=VcoZJ88d-vM)

<img src="https://github.com/cs4372/ios-study-guide/blob/master/swift/Automatic-Reference-Count/arc-code.png"/>

<img src="https://github.com/cs4372/ios-study-guide/blob/master/swift/Automatic-Reference-Count/arc-diagram.png"/>

^ Prior to setting a weak reference to the owner property inside MacBook Class, Sean has a reference to himself and Mathilda has a reference to herself.
Strong references from both of them pointing to each other. This is bad since it's a retain cycle.

If we ONLY have `sean = nil`, Mathilda will still point to sean and sean will not be removed from memory. It can only be removed from memory
if ARC is equal to 0.

<img src="https://github.com/cs4372/ios-study-guide/blob/master/swift/Automatic-Reference-Count/arc-weak.png"/>

If we make the owner variable weak, there will be no strong reference pointing to Sean. So, if we make `sean = nil`, then he can be removed from memory
because matilda is not holding on to him anymore. This clears the retain cycle.

#### `weak self` in different scenarios:

1. Notification Center

```
class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register observer for "CustomNotification"
        NotificationCenter.default.addObserver(forName: Notification.Name("CustomNotification"), object: nil, queue: nil) { [weak self] _ in
            // Update the background color using weak self
            self?.backgroundView.backgroundColor = .red
        }
    }
    
    deinit {
        // Remove observer when ViewController is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    // Function to simulate posting the "CustomNotification"
    func postCustomNotification() {
        NotificationCenter.default.post(name: Notification.Name("CustomNotification"), object: nil)
    }
}
```

- In this example, we want to update the background color of backgroundView when a custom notification named "CustomNotification" is received. Within the closure that handles the notification in `NotificationCenter`, we capture self weakly using [weak self] to avoid a strong reference cycle
- The optional chaining (self?) ensures that the background color is only updated if self (the ViewController) still exists. If self has been deallocated, the weak reference will be nil, and the background color update will be skipped
- By using weak self in this scenario, we prevent a potential retain cycle between the closure and the ViewController. It allows the ViewController to be deallocated properly when it's no longer needed, while still being able to handle the notification and update the UI if it's still available

2. Asynchronous Network Request

```
class DataManager {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        // Simulating an asynchronous network request
        DispatchQueue.global().async {
            // Perform the network request and get the data
            
            // Call the completion handler, using weak self to avoid a strong reference cycle
            completion(.success(data))
        }
    }
}

class ViewController: UIViewController {
    let dataManager = DataManager()
    
    func loadData() {
        dataManager.fetchData { [weak self] result in
            // Handle the result using weak self to avoid retain cycle
            
            DispatchQueue.main.async {
                // Update the UI based on the result
            }
        }
    }
}
```

3. Timer-based Actions

```
class ViewController: UIViewController {
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            // Perform timer-based action using weak self to avoid retain cycle
            
            // Update the UI or perform any other desired action
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
}
```

- By capturing self weakly in the closure, we ensure that the ViewController can be deallocated even if the timer is still active. It helps prevent a strong reference cycle between the timer closure and the ViewController

Resources:
- https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting
- https://developer.apple.com/videos/play/wwdc2021/10216/
- [Retain Cycle, Automatic Reference Counting, Memory Leak](https://www.youtube.com/watch?v=VcoZJ88d-vM)
- https://betterprogramming.pub/a-look-into-automatic-reference-counting-b17e9539d34f
- https://trycombine.com/posts/self-weak-unowned/
