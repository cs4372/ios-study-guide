## Reactive Programming
- A paradigm where entities observe and respond to events or changes in data, enabling the UI to react accordingly.

## Combine 

- Declarative, reactive framework for processing asynchronous events over time
- Revolves around three main types: `publishers` to emit events over time, `operators` to asynchronously process and manipulate upstream events and `subscribers` to consume the results and do something useful with them.

### Publishers 
- Publish/emit an event 

### Subscriptions
- Listen to a change/event 

### Example 
A Switch is a publisher
- It toggles on and off 
- When you toggle on and off, it sends the event. Once it's sent, we can have the light bulb.

A light bulb is a subscription which listens to the event (the toggle) we've sent and it changes based on the emitted event.

###  Useful classes in Combine:
#### AnyCancellable
- concrete class that conforms to the `Cancellable` protocol
- Use `AnyCancellable` to manage the lifecycle of subscriptions and cancel them when needed to prevent potential memory leaks
- When you subscribe to a publisher, the publisher returns an AnyCancellable, which you can use to retain a reference to the subscription and cancel it later when you no longer need updates from the publisher.


#### PassthroughSubject
- comform to the `Subject` and `ObservableObject`protocol. Is a powerful publisher that allows you to manually emit values and completion events, making it useful for creating custom Combine publishers.
- It manually sends values to its subscribers using the send(_:) method.
- When you send a value through a PassthroughSubject, it immediately forwards that value to all of its subscribers, and they can react to it using Combine operators like sink.
- When you create a PassthroughSubject, it starts without an initial value. It will only emit values that are sent to it after subscribers have attached.
- Does not retain the latest value sent to it. If a new subscriber joins, it won't receive the most recent value that was sent before it subscribed.
- It is generally used when you want to manually control what values are sent through the subject. E.g. fetching data from a network request and manually publishing the received data through the `PassthroughSubject`.
- In short, `PassthroughSubject` doesn't rememeber old messasges. It doesn't have an initial value and doesn't remember the last value sent.

#### CurrentValueSubject
- It requires an initial value and when you create it, you must give it an initial value.
- It remembers and retains the latest value sent to it, even before any subscriber joins. 
- It is used when you have a value that changes over time, and you want subscribers to get the latest value when they start observing. E.g. great for representing state or handling user inputs like sliders or text fields.
- In short, `CurrentValueSubject` remembers older messages. It requires an initial valueand keeps track of the latest value.
  
#### Why use eraseToAnyPublisher()?
- Explain from [Stackoverflow](https://stackoverflow.com/questions/56611057/can-anyone-explain-swift-combines-subject-erasetoanysubject-method-and-where)
- In short, eraseToAnyPublisher() method uses a type eraser pattern to capture only the essential information about the return type and make it more succinct.

Resources:
- [Master The Combine Framework: From Beginner to Advanced](https://www.youtube.com/watch?v=X2m0f2NoB10)
- [MVVM Combine Swift (2022) | UIKit | Transform Input & Output video](https://www.youtube.com/watch?v=KK6ryBmTKHg&t=206s&pp=ygUTdWlraXQgY29tYmluZSBzd2lmdA%3D%3D)
- [Getting started with Combine](https://useyourloaf.com/blog/getting-started-with-combine/)
- [Getting started with Combine + UIKit in Swift video](https://www.youtube.com/watch?v=IAKco9XaPgg&t=319s)