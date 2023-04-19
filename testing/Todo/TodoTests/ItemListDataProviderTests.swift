//
//  ItemListDataProviderTests.swift
//  TodoTests
//
//  Created by Catherine Shing on 4/18/23.
//

import XCTest
@testable import Todo

final class ItemListDataProviderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_NumberOfSections_IsTwo() {
      let sut = ItemListDataProvider()
      let tableView = UITableView()
      tableView.dataSource = sut
       

      let numberOfSections = tableView.numberOfSections
      XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_NumberOfRows_Section1_IsToDoCount() {
        
        let sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        let tableView = UITableView()

        tableView.dataSource = sut
        tableView.delegate = sut

        sut.itemManager?.add(TodoItem(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(TodoItem(title: "Bar"))
        
        tableView.reloadData() // Reload table view data with new item
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
}
