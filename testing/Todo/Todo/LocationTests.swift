//
//  LocationTests.swift
//  TodoTests
//
//  Created by Catherine Shing on 4/16/23.
//

import XCTest
@testable import Todo
import CoreLocation

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_setsName() {

      let location = Location(name: "Dummy")

      XCTAssertEqual(location.name, "Dummy")
    }
    
    func test_init_setsCoordinate() throws {

      let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
      let location = Location(name: "", coordinate: coordinate)

      let resultCoordinate = try XCTUnwrap(location.coordinate)

      XCTAssertEqual(resultCoordinate.latitude, 1, accuracy: 0.000_001)
      XCTAssertEqual(resultCoordinate.longitude, 2, accuracy: 0.000_001)
    }
    
    func test_EqualLocations_AreEqual() {
      let first = Location(name: "Foo")
      let second = Location(name: "Foo")
       
      XCTAssertEqual(first, second)
    }
    
    func test_Locations_WhenLatitudeDiffers_AreNotEqual() {
      assertLocationNotEqualWith(firstName: "Foo",
                                 firstLongLat: (1.0, 0.0),
                                 secondName: "Foo",
                                 secondLongLat: (0.0, 0.0))
    }
    
    func test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual() {
      assertLocationNotEqualWith(firstName: "Foo",
                                 firstLongLat: (0.0, 0.0),
                                 secondName: "Foo",
                                 secondLongLat: nil)
    }
    
    func assertLocationNotEqualWith(firstName: String,
                                    firstLongLat: (Double, Double)?,
                                    secondName: String,
                                    secondLongLat: (Double, Double)?) {
      
      var firstCoord: CLLocationCoordinate2D? = nil
      if let firstLongLat = firstLongLat {
        firstCoord =
          CLLocationCoordinate2D(latitude: firstLongLat.0,
                                 longitude: firstLongLat.1)
      }
      let firstLocation =
        Location(name: firstName,
                 coordinate: firstCoord)
      
      
      var secondCoord: CLLocationCoordinate2D? = nil
      if let secondLongLat = secondLongLat {
        secondCoord =
          CLLocationCoordinate2D(latitude: secondLongLat.0,
                                 longitude: secondLongLat.1)
      }
      let secondLocation =
        Location(name: secondName,
                 coordinate: secondCoord)
      
      
      XCTAssertNotEqual(firstLocation, secondLocation)
    }
}
