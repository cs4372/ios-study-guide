## Delegation 

-  a design pattern that enables a class to hand off (or delegate) some of its responsibilities to an instance of another class
-  Delegates that reference other classes that they do not own should use the weak keyword to avoid strong reference cycles. 
- ----> avoid retain cycle (basically want to avoid a strong reference between these 2. One of them can be strong (ViewController can strongly hold the WeatherService) but we want the link (weatherService → ViewController) to be weak so we won’t leak memory by strongly referencing each other

Example:

<img src="https://github.com/cs4372/ios-study-guide/blob/master/swift/Delegation/delegation.png"/>

```
class ViewController: UIViewController {

let weatherService = weatherService()

……..
weatherService.delegate = self // self is the ViewController, sign me up, i want to be your delegate (intern)

}

class WeatherService { 
    // weak var ⇒ weakly holds a reference back to the object that is setting 
    weak var delegate: WeatherServiceDelegate?  // WeatherService is the boss, when I’m creating a new weatherService, I’m also initializing a delegate that I have set in weatherService.delegate = self
    ViewController is the delegate 
    ……
}
```
