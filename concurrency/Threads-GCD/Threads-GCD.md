### Threads, Concurrency, Parallelism, Grand Central Dispatch, Queues
<img src="https://github.com/cs4372/ios-study-guide/blob/master/concurrency/concurrency-parallelism.jpeg" height="200"/>

### Concurrency (Handling multiple tasks or processes at the same time)
- Multiple tasks progress at the same time but are not executed simultaneously 
- Concurrent tasks can either be executed sequentially whereby one task is completed before another one starts or concurrently where there is switching between tasks until all tasks are completed
- Accomplishes multiple tasks faster

### Parallelism (Executing multiple tasks simultaneously)
- Executing multiple tasks in parallel
- Parallel tasks are split into subtasks that are assigned to multiple workers and then completed simultaneously.
- Not as efficient as many workers are used to accomplish 1 task

“Concurrency is about dealing with many things at once, parallelism is about doing many things at once. Concurrency is a way to structure things so you can maybe use parallelism to do a better job.” - Rob Pike

### Process
- A process represents an individual running application
- Has at least 1 thread 
- Each process runs independently and has its own memory space, file handles, and system resources
- In iOS, each app typically runs as a separate process, ensuring isolation and security

### Threads
- is a lightweight unit of execution within a process
- Multiple threads can exist within a single process, each running concurrently and performing different tasks
- Threads share the same memory space within a process, allowing them to access and modify shared data

In iOS, threads are categorized into two as below:
Main thread, which is to display your user interface and listen for events.
Background thread, which mostly works with long running tasks such as network request, db queries.

Complex computations may slow down the main thread and freeze the app, hence it is where `multithreading` comes into play. We have to move all the heavy lifting to a background thread, and then move the result back to the main.

### Race Condition
- Happens when mulitple threads are trying to access the same shared resources.

### Queues 

A queue is just a bunch of code blocks, queued up waiting for a thread to execute them. We don't really need to worry about threads in Swift. Only queues. The system takes care of allocating threads to execute code off the queues. 

###  2 ways to achieve concurrency: Grand Central Dispatch and OperationQueue

### Grand Central Dispatch (GCD)
- low-level framework that provides a set of APIs for managing concurrent tasks on multiple threads
- Manage your queues in the First-in First-out order and handle concurrent operations.

Responsibility:
- Create a queue 
- Put blocks of code on a queue

#### Queues and Closures

{
    Blocks of code waiting in a queue are held in a closure
}

### 2 types of dispatch queues: serial and concurrent

#### Main Queue (Serial)
- Execute one task at a time
- Tasks come in in order, everything happens 1 at a time, in order

Task 4 -> Task 3 -> Task2 -> Task 1
- Task 2 won't start until Task 1 is 100% complete

- Most important one of all. The queue where all blocks of code that affect the UI must be run on. System uses a single thread to process all the blocks of code in the main queue

Pros: 
- Predictable Execution Order
- Prevents Race Condition (when two or more threads compete to access shared data concurrently, leading to unexpected and inconsistent outcomes)

Cons:
- Slower 

#### Background Queues (Concurrent)
- Execute multiple tasks simultaneously
- Everything still starts in order but Task 2 doesn't have to wait until Task 1 to start
- Order of completion is unpredictable as Task 4 can finish sooner than Task 2
- Uses to queue up any long-lived, non UI tasks
- Often running simultaneously and in parallel with the main UI queue
- Use quality of service (QoS) to determine which queue gets more proriotiy over others

Pros:
- Faster
- Unpredictable Order

### Creating Queues 

#### Main Queue (DispatchQueue.main)
- used for performing UI-related tasks, such as updating UI elements or interacting with UI frameworks
- Place response from API request, db queries

E.g.

```
func configure(with name: String, url: URL?) {
    // Configure Name Label
    nameLabel.text = name

    // Load Image
    if let url = url {
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
    }
}
```

```
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
   if let data = data {
      DispatchQueue.main.async { // On main thread to update UIKit class i.e UILabel
         self.label.text = "\(data.count) bytes downloaded"
      }
   }
}
task.resume()
```

#### Background Queues(DispatchQueue.global)
- Working with long running tasks such as network request, db queries
- can offload these tasks to a global background queue, allowing them to run concurrently and asynchronously without blocking the main thread. This helps to maintain a responsive UI and prevent the app from freezing or becoming unresponsive while waiting for the network or database operations to complete

### DispatchQueue.global().sync
- Avoid using DispatchQueue.global().sync on the main thread as it can lead to deadlocks or blocking the UI

#### Background Queues (QoS)(in the order of priority)
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

### OperationQueue
- High-level abstraction that builds on top of GCD (to focus less on details of how concurrent execution will be done and more on the implementation of our business logic)
- Provides a class called Operation, which represents a unit of work that can be executed asynchronously.
- Think of an OperationQueue as a line of tasks waiting to be executed. Unlike dispatch queues in GCD, operation queues are not FIFO (first-in-first-out). Instead, they execute tasks as soon as they are ready to be executed, as long as there are enough system resources to allow for it.
- More customization, you can set the max number of concurrent operations within the queue, add dependencies between tasks, etc

```
let blockOperation = BlockOperation {
    print("Executing!")
}

let queue = OperationQueue()
queue.addOperation(blockOperation)

queue.addOperation {
  print("Executing!")
}
```

Usecases:
GCD -> Dealing with simple concurrent tasks and you want a more lightweight and efficient approach.
OperationQueue -> Dealing with more complex workflows, dependencies between tasks, and a need for customization and observability.

[OperationQueue Explained](https://holyswift.app/operationqueues-in-swift-more-control-to-your-async-operations-with-asynchronous-dependency-graph/)

### Threads can be used for both asynchronous and synchronous execution.

#### Synchronous
- The program waits until execution finishes before the method call returns. It will block the user from doing anything until it is executed 
- Blocks the main thread until closure execution is completed
- Only use if necessary

```
DispatchQueue.main.sync { 
    // Code to be executed
    self.tableView.reloadData()
}
```

#### Asynchronous (most common)
- The method call DispatchQueue.global().async returns immediately after enqueuing the provided closure (the block of code) for execution on the global queue. 
- It does not wait for the code inside the closure to complete before returning
- So program will continue executing the subsequent code without being blocked by the code inside the closure
```
DispatchQueue.global().async { 
    // Code to be executed
}
```

Examples:

* System is executing the tasks on the main thread, which is the default behavior for global queues when using sync.
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

### Tips:

#### How to check what the current thread is?
- Use the Thread.current property in Swift
- E.g. print("Current Thread = \(Thread.current)")

#### Do not use DispatchQueue.main.sync { ... }
- Attempting to synchronously execute a work item on the main queue results in deadlock
- Do not update UI from a background thread

### Questions:
#### Why long-running tasks shouldn’t be done on the main thread?
- Main thread is responsible for handling user interface updates and interactions.
- Is precious resource that should be reserved for UI-related tasks that require quick response times. 
- If a long-running task is executed on the main thread, it blocks the thread and prevents the UI from responding to user interactions or updating its appearance. This can lead to a frozen or unresponsive UI, creating a poor user experience. 
- Also can lead to Thread Starvation, where the thread becomes busy with a single task and is unable to perform other critical tasks.

Resources:
- [Concurrent vs Parallel Tasks for a Worker System](https://blog.iron.io/concurrent-vs-parallel-tasks-for-a-worker-system/)
- [Threads and Group Central Dispatch](https://www.youtube.com/watch?v=uRLcV2Rvheg)
- [Parallel Programming with Swift — Part 1/4](https://medium.com/swift-india/parallel-programming-with-swift-part-1-4-df7caac564ae)
