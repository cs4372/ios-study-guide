## Timer 

Timer is used for scheduling tasks after a specific time interval.

#### Scheduling a repeating task
```

private var timer: Timer?

override func viewDidLoad() {
    super.viewDidLoad()

    // scheduling a timer in repeat mode after each 1 second.
    self.timer = Timer.scheduledTimer(timeInterval: 1,
    target: self, selector: #selector(handleTimerExecution), userInfo: nil, repeats: true)
}

@objc private func handleTimerExecution() {
    print("timer executed...")
}
```

Note: The @objc attribute makes the handleTimerExecution() function available in Objective-C. And the timer class is a part of Objective-C runtime, that's why we need the @objc attribute here.

#### Scheduling a repeating task using a closure:
```
let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
    print("timer executed...")
}
```

#### Stop a repeating timer
```
private var timerCurrentCount = 0

let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
    // check for max execution count of timer.
    if self.timerCurrentCount == 5 {
        timer.invalidate() // invalidate the timer
    } else {
        print("timer executed...")
        self.timerCurrentCount += 1
    }
}
```

#### Alternative approach to define a non-repeating task using GCD like below:

```
DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
   print("timer executed")
}
```

Resources:

- https://www.swiftanytime.com/ultimate-guide-on-timer-in-swift/ 
- https://codewithchris.com/swift-timer/
