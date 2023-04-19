//
//  ItemListViewControllerTest.swift
//  TodoTests
//
//  Created by Catherine Shing on 4/18/23.
//

import XCTest
@testable import Todo

final class ItemListViewControllerTest: XCTestCase {
    
    var sut: ItemListViewController!
    var tableView: UITableView!
    var controller: ItemListViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController =
          storyboard.instantiateViewController(
            withIdentifier: "ItemListViewController")
        sut = viewController as! ItemListViewController
        sut.loadViewIfNeeded()
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_DataSourceEqualDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
    }

    override func setUpWithError() throws {
        setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
