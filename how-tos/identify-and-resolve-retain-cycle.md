## How to identify and resolve retain cycles?

Memory leak in iOS is when an amount of allocated space in memory cannot be deallocated due to retain cycles. 
Swift uses Automatic Reference Counting(ARC), a retain cycle occurs when 2 or more objects hold strong references to each other. Therefore, these objects retain each other in memory because their retain count would never decrement to 0, which would prevent memory frmo being freed
Effects of memory leaks => OOM (out of memory) crash, lead to unpredicable crashes/behavior
  
2 main ways to detect memory leaks:
1. Using the Xcode Memory Graph tool. Take a snapshot of the current state of the app. Visualize object references and check if any retain cycles exist.
2. Use Instruments, like the "Leaks" instruments, to profile your app's memory usage and find memory leaks. Look for objects that are not getting deallocated when they should.

Resources:
1. https://www.netguru.com/blog/what-are-ios-memory-leaks-and-how-to-detect-them
2. https://doordash.engineering/2019/05/22/ios-memory-leaks-and-retain-cycle-detection-using-xcodes-memory-graph-debugger/