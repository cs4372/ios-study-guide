//
//  TodoItemTests.swift
//  TodoTests
//
//  Created by Catherine Shing on 4/16/23.
//

import XCTest
@testable import Todo

final class ToDoItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_whenGivenTitle_setsTitle() {

      let item = TodoItem(title: "Dummy")
      XCTAssertEqual(item.title, "Dummy")

    }
    
    func test_init_whenGivenDescription_setsDescription() {
        let item = TodoItem(title: "Dummy", itemDescription: "DummyDescription")
        XCTAssertNotNil(item.itemDescription, "DummyDescription")
    }
    
    func test_init_setsTimestamp() throws {

      let dummyTimestamp: TimeInterval = 42.0
      let item = TodoItem(title: "Dummy", timestamp: dummyTimestamp)
      let timestamp = try XCTUnwrap(item.timestamp)

      XCTAssertEqual(timestamp, dummyTimestamp, accuracy: 0.000_001)
    }
    
    func test_init_whenGivenLocation_setsLocation() {

      let dummyLocation = Location(name: "Dummy Name")
      let item = TodoItem(title: "Dummy Title", location: dummyLocation)

      XCTAssertEqual(item.location?.name, dummyLocation.name)

    }
    
    func test_Items_WhenDescriptionsDiffer_AreNotEqual() {

      let first = TodoItem(title: "Foo",
                           itemDescription: "Bar")
      let second = TodoItem(title: "Foo",
                            itemDescription: "Baz")
       
      XCTAssertNotEqual(first, second)
    }
}
