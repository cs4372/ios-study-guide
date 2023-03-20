### Threads and Grand Central Dispatch

### Threads

Every iOS application has a main thread, which is to display your user interface and listen for events. 

Complex computations may slow down the main thread and freeze the app, hence it is where multithreading comes into play. We have to move all the heavy lifting to a background thread, and then move the result back to the main.

### Queues 

A queue is just a bunch of code blocks, queued up waiting for a thread to execute them. We don't really need to worry about threads in Swift. Only queues. The system takes care of allocating threads to execute code off the queues. 

### Grand Central Dispatch (GCD)

- The API responsible for managing your queues

Responsibility:
- Create a queue 
- Put blocks of code on a queue

#### Queues and Closures

{
    Blocks of code waiting in a queue are held in a closure
}

### Different Queues

#### Main Queue 
- Most important one of all. The queue where all blocks of code that affect the UI must be run on. System uses a single thread to process all the blocks of code in the main queue

#### Background Queues
- Uses to queue up any long-lived, non UI tasks
- Often running simultaneously and in parallel with the main UI queue
- Use quality of service (QoS) to determine which queue gets more proriotiy over others

### Creating Queues 

#### Main Queue 
- DispatchQueue.main

#### Background Queues
- DispatchQueue.global(qos: QoS)

#### Background Queues (in the order of priority)
`.userInteractive`

- have the highest priority on the system 
- Use this class for tasks/queues that interfact with the user or actively update your app's user interface
- E.g. use this for class for animations / for tracking events interactively 

`.userInitated`
- second only to user-interactive tasks in priority on the system
- Assign this class to tasks that provide immediate results for something the user is doing, or that would prevent the user from using your app
- E.g you might use this class to load the content of an email that you want to display to the user

`.default`
If you don't specific a QoS, then it will be set to default

`.utility`
- lower priority than other tasks but not background tasks
- Assign this class to tasks that do not prevent the user from continuing to user the app
- E.g assign this class to long-running tasks whose progress the user does not follow actively 

`.background`
- lowest priority of all task 
- Assign this class to asks or dispatch queues that you use to perform work while your app is running in the background 
- E.g. Maintenance tasks or cleanup

### Synchronous vs Asynchronous 

#### Synchronous
- The program waits until execution finishes before the method call returns. It will block the user from doing anything until it is executed 

```
DispatchQueue.main.sync { 
    // Code to be executed
}
```

#### Asynchronous (most common)
- method call returns immediately without waiting for the task to completes
  
```
DispatchQueue.global().async { 
    // Code to be executed
}
```

Examples:

```
DispatchQueue.global().sync {
    sleep(2)
    print("sync: Inside")
}

print("sync: Outside")
/*
sync: Inside
sync: Outside
*/
```

```
DispatchQueue.global().async {
    sleep(2)
    print("async: Inside")
}

print("async: Outside")
/*
async: Outside
async: Inside
*/
```

#### Get image url and upate image 

Update UI in the main thread

```
DispatchQueue.global(qos: .userInteractive).async { 
    guard let jsonURL = URL(string: url) else { 
        fatalError("Invalid url)
    }
    guard let imageJSON = try? Data(contentsOf: jsonURL) else {
        fatalError("Could not get data from jsonURL")
    }
    guard let thisDog = try? decoder.decode(Dog.self, from: imageJSON) else {
        fatalError("There must be a problem decoding....")
    }
    guard let imageURL = URL(string: thisDog.imageURL) else {
        fatalError("Dog imageURL is invalid")
    }
    guard let imageData = try? Data(contentsOf: imageURL) else {
        fatalError("Can't get dog image data")
    }
    sleep(2)
    DispatchQueue.main.async { 
        self.image = UIImage(data: imageData)
    }
}
```

Instead of using `DispatchQueue.global(qos: .userInteractive).async..`, use `URLSession.shared.dataTask` to get the image url. It will execude the code in the background thread.

```
session.dataTask(with: jsonURL) { (data, _, error) in
    ....
}
```

#### DispatchGroup 

- Allows you to add a set of tasks and schedule them for asynchronous execution. This behaviour can be helpful when progress can’t be made until all of the specified tasks are complete. 

```
let queue = DispatchQueue.global()
let group = DispatchGroup()

queue.async(group: group) { 
    sleep(3)
    print("Task 1 done")
}

queue.async(group: group) { 
    sleep(1)
    print("Task 2 done")
}

group.wait() // Everything must wait until all the group tasks are done
print("All tasks done")
print("Continue Execution")
```

Resources:
- [Threads and Group Central Dispatch](https://www.youtube.com/watch?v=uRLcV2Rvheg)