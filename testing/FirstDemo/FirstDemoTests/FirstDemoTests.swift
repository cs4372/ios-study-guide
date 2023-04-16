//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by Catherine Shing on 4/16/23.
//

import XCTest
@testable import FirstDemo

final class FirstDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_numberOfVowels_whenGivenDominik_shouldReturn3() {

      let viewController = ViewController()

      let result = viewController.numberOfVowels(in: "Dominik")

      XCTAssertEqual(result, 3,

        "Expected 3 vowels in 'Dominik' but got \(result)")
    }
}
