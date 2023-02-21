## Delegation 

-  a design pattern that enables a class to hand off (or delegate) some of its responsibilities to an instance of another class
-  Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.
-  Delegates that reference other classes that they do not own should use the weak keyword to avoid strong reference cycles. 
- ----> avoid retain cycle (basically want to avoid a strong reference between these 2. One of them can be strong (ViewController can strongly hold the WeatherService) but we want the link (weatherService → ViewController) to be weak so we won’t leak memory by strongly referencing each other

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