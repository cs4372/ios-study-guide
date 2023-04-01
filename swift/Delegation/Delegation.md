## Delegation 

-  a design pattern that enables a class to hand off (or delegate) some of its responsibilities to an instance of another class to perform a specific task / set of tasks, while the first class retains control over the overall process 
-  Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.
-  Delegates that reference other classes that they do not own should use the weak keyword to avoid strong reference cycles. 
- ----> avoid retain cycle (basically want to avoid a strong reference between these 2. One of them can be strong (ViewController can strongly hold the WeatherService) but we want the link (weatherService → ViewController) to be weak so we won’t leak memory by strongly referencing each other

Delegates are commonly used to handle events and control behavior. For example, a view controller may delegate responsibilities to a text field, such as validating user input or dismissing the keyboard when the user finishes editing. The view controller can still control the overall behavior of the app, but the text field handles the specific responsibilities assigned to it by the view controller. Similarly, a table view may delegate responsibilities to a data source, such as providing the content to be displayed and responding to user interactions, while the table view itself handles the presentation and scrolling of the content.

Analogy: 

Imagine a person who needs to book a hotel room. The person may delegate this responsibility to a travel agent, who can search for available hotels, make a reservation, and handle any issues that arise during the booking process. The person can still control the overall process by specifying their preferences and requirements, but the travel agent does the actual work of booking the hotel.


Example 1:

<img src="https://github.com/cs4372/ios-study-guide/blob/master/swift/Delegation/delegation.png"/>

```
class ViewController: UIViewController {

let weatherService = weatherService()

...
weatherService.delegate = self // self is the ViewController, sign me up, i want to be your delegate (intern)

}

class WeatherService { 
    // weak var ⇒ weakly holds a reference back to the object that is setting 
    weak var delegate: WeatherServiceDelegate?  // WeatherService is the boss, when I’m creating a new weatherService, I’m also initializing a delegate that I have set in weatherService.delegate = self
    ViewController is the delegate 
    ...
}
```

Example 2:

```
// A protocol is like a list of rules that need to be followed.
protocol OlderSiblingDelegate: class {
    // The following command (ie, method) must be obeyed by any 
    // underling (ie, delegate) of the older sibling.
    func getYourNiceOlderSiblingAGlassOfWater()
}

// MARK: Characters in the story

class BossyBigBrother {
    
    // I can make whichever little sibling is around at 
    // the time be my delegate (ie, slave)
    weak var delegate: OlderSiblingDelegate?
    
    func tellSomebodyToGetMeSomeWater() {
        // The delegate is optional because even though 
        // I'm thirsty, there might not be anyone nearby 
        // that I can boss around.
        delegate?.getYourNiceOlderSiblingAGlassOfWater()
    }
}

// Poor little sisters have to follow (or at least acknowledge) 
// their older sibling's rules (ie, protocol)
class PoorLittleSister: OlderSiblingDelegate {

    func getYourNiceOlderSiblingAGlassOfWater() {
        // Little sis follows the letter of the law (ie, protocol),
        // but no one said exactly how she had to respond.
        print("Go get it yourself!")
    }
}

// MARK: The Story

// Big bro is laying on the couch watching basketball on TV.
let bigBro = BossyBigBrother()

// He has a little sister named Sally.
let sally = PoorLittleSister()

// Sally walks into the room. How convenient! Now big bro 
// has someone there to boss around.
bigBro.delegate = sally

// So he tells her to get him some water.
bigBro.tellSomebodyToGetMeSomeWater()
```

Example 3:

```
@IBOutlet weak var activityTextField: UITextField!
@IBOutlet weak var timeTextField: UITextField!

override func viewDidLoad() {
    super.viewDidLoad()
    timeTextField.delegate = self
}

// shut down the keyboard if user taps anywhere outside of text field
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
}

// shut down the keyboard if user taps Return on keyboard
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
}

```

By setting the delegate of the text field to the ViewController, the controller can receive notifications and control events from the text field. E.g. the view controller can be notified when the user started editing the text field / when the user finishes editing the text field. In this case, view controller can control the behavior of the text fields e.g. by dismissing the keyboard of validating the user input. 

### In review, there are three key parts to making and using the delegate pattern.

1. the **protocol** that defines what the worker needs to do
2. the **boss class** that has a delegate variable, which it uses to tell the worker class what to do
3. the **worker class** that adopts the protocol and does what is required

Why use delegation? 
- promotes reuse 
- decoupling classes

Resources:
- https://stackoverflow.com/questions/24099230/delegates-in-swift/42307362#42307362
- https://www.youtube.com/watch?v=JV1BKdz9hUA 
- https://www.youtube.com/watch?v=qiOKO8ta1n4  - Swift Delegate Protocol Pattern Tutorial
- [Passing Data between controllers](https://medium.com/@astitv96/passing-data-between-view-controllers-using-delegate-and-protocol-ios-swift-4-beginners-e32828862d3f)
