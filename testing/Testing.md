## Testing

#### Unit Testing: 
- covers a very small part of your app’s logic
- only test micro features in isolation

#### Integration Testing:
- where individual units/components are combined and tested as a group
- to assert that different units (thoroughly tested with unit tests) interact with each other as required
- execute real database queries and fetch data from live servers, which makes them significantly slower than unit tests

#### UI Testing:
- UI tests run on the UI of an app
- e.g. is the button disabled or not?

#### Snapshot tests:
- Snapshot tests compare the UI with previously taken snapshots. 
- If a defined percentage of pixels differs from the snapshot image, the test fails

#### XCTest: 
- create and run unit tests, performance tests, and UI tests for your Xcode project

The test method should contain three steps, in the order described below:

1. Arrange: create the necessary dependencies
2. Act: call the method or function that you’re testing, using parameters and properties that you configure in the Arrange phase.
3. Assert: verifies the outcome of the test behaves as expected


### Unit Tests Setup:

```
import XCTest
@testable import FirstDemo (Project name)
```

- Every test case needs to import the XCTest framework. It defines the XCTestCase class and the test assertions that you will see later in this chapter.
- The second line imports the FirstDemo module. All the code you write for the demo app will be in this module. 

```
override func setUpWithError() throws {

  // Put setup code here. This method ...

}

override func tearDownWithError() throws {

  // Put teardown code here. This method ...

}
```

- The `setUpWithError()` method is called before the invocation of each test method in the class. Here, you can insert the code that should run before each test.

- The tearDownWithError() method is called after the invocation of each test method in the class. If you need to clean up after your tests, put the necessary code in this method.

```
func testExample() throws {

  // This is an example of a functional test case.

  // Use XCTAssert and related functions to ...

}

func testPerformanceExample() throws {

  // This is an example of a performance test case.

  self.measure {

    // Put the code you want to measure the time of here.

  }

}
```

- The first method is a normal unit test.
- The second method is a performance test. It is used to test methods or functions that perform time-critical computations. The code you put into the measure closure is called 10 times, and the average duration is measured. Performance tests can be useful when implementing or improving complex algorithms and to make sure that their performance does not decline. 

### Set a breakpoint that breaks on test failure

1. Open breakpoint navigator
2. At the bottom of the navigator view is a button with a plus sign (+). Click on it, and select Test Failure Breakpoint

#### Run tests
1. Go to Product => Click Test
   
#### Disabling slow UI tests
1. Open the scheme selection and click on Edit Scheme
2. Select the Test option and uncheck the FirstDemoUITests target or Click Manage Schemas to uncheck the target

#### Dealing with optional values in unit tests

Use `XCTUnwrap(_:)`. This function unwraps its parameter and returns the unwrapped value. If the parameter is nil, this function throws an error. 

#### Equitable
- a protocol that allows two objects to be compared using the == operator

Resources:
- https://developer.apple.com/documentation/xcode/testing-your-apps-in-xcode?changes=_5
- https://developer.apple.com/documentation/xctest
- Test-Driven iOS Development with Swift - Fourth Edition By Dr. Dominik Hauser
- [Applying Unit Tests to MVVM with Swift](https://medium.com/@koromikoneo/applying-unit-tests-to-mvvm-with-swift-ba5a79df8a18)