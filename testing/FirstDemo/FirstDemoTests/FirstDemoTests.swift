//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by Catherine Shing on 4/16/23.
//

import XCTest
@testable import FirstDemo

final class FirstDemoTests: XCTestCase {
    
    var blogger: Blogger!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        blogger = Blogger()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        blogger = nil
    }
    
    func test_numberOfVowels_whenGivenDominik_shouldReturn3() {

      let viewController = ViewController()
      let result = viewController.numberOfVowels(in: "Dominik")

      XCTAssertEqual(result, 3, "Expected 3 vowels in 'Dominik' but got \(result)")
    }
    
    func test_makeHeadline_shouldCapitalisePassedInString() {

      let blogger = Blogger()
      let input = "the Accessibility inspector"

      let result = blogger.makeHeadline(from: input)
      let expected = "The Accessibility Inspector"

      XCTAssertEqual(result, expected)
    }
    
    func test_reverseString() {

      let input = "Dusty is my pup"
        
      let result = blogger.reverseString(from: input)
      let expected = "pup ym si ytsuD"

      XCTAssertEqual(result, expected)
    }
    
    func test_createFile() {
        let input = "This IS a NEW FilE"
        
        let result = blogger.createFile(from: input)
        let expect = NSHomeDirectory() + "this_is_a_new_file"
        
        XCTAssertEqual(result, expect)
    }
}
