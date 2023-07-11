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

Resources:
- [Master The Combine Framework: From Beginner to Advanced](https://www.youtube.com/watch?v=X2m0f2NoB10)
