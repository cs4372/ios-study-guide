//
//  ItemManagerTests.swift
//  TodoTests
//
//  Created by Catherine Shing on 4/17/23.
//

import XCTest
@testable import Todo

final class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_TodoCount_Initially_IsZero() {
      XCTAssertEqual(sut.todoCount, 0)
    }
     
    func test_DoneCount_Initially_IsZero() {
      XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_AddItem_IncreasesToDoCountToOne() {
      sut.add(TodoItem(title: ""))
        
      XCTAssertEqual(sut.todoCount, 1)
    }
    
    func test_ItemAt_ReturnsAddedItem() {
      let item = TodoItem(title: "Foo")
      sut.add(item)
       
      let returnedItem = sut.item(at: 0)
        
      XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCounts() {
      sut.add(TodoItem(title: ""))
       
      sut.checkItem(at: 0)
        
      XCTAssertEqual(sut.todoCount, 0)
      XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemovesItFromToDoItems() {
      let first = TodoItem(title: "First")
      let second = TodoItem(title: "Second")
      sut.add(first)
      sut.add(second)
      
      sut.checkItem(at: 0)
            
      XCTAssertEqual(sut.item(at: 0).title,
                     "Second")
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
      let item = TodoItem(title: "Foo")
      sut.add(item)
       
      sut.checkItem(at: 0)
      let returnedItem = sut.doneItem(at: 0)
        
      XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_Items_WhenLocationDiffers_AreNotEqual() {
      
      let first = TodoItem(title: "",
                           location: Location(name: "Foo"))
      let second = TodoItem(title: "",
                            location: Location(name: "Bar"))
     
      XCTAssertNotEqual(first, second)
    }
    
    func test_RemoveAll_ResultsInCountsBeZero() {
        sut.add(TodoItem(title: "Foo"))
        sut.add(TodoItem(title: "Bar"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.todoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
       
        sut.removeAll()
        
        XCTAssertEqual(sut.todoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
}
