import UIKit
import XCTest
import UptakeToolbox

class RangesTests: XCTestCase {
  func testWithinInt() {
    let min: Int = 5
    let max: Int = 10
    let low: Int = 1
    let high: Int = 20
    
    XCTAssertEqual(low.within(min...max), min)
    XCTAssertEqual(high.within(min...max), max)
    XCTAssertEqual(min.within(min...max), min)
    XCTAssertEqual(max.within(min...max), max)
  }


  func testWithinFloat() {
    let min: Float = 5.5
    let max: Float = 10.5
    let low: Float = 1.5
    let high: Float = 20.5
    
    XCTAssertEqual(low.within(min...max), min)
    XCTAssertEqual(high.within(min...max), max)
    XCTAssertEqual(min.within(min...max), min)
    XCTAssertEqual(max.within(min...max), max)
  }

  
  func testWithinDouble() {
    let min: Double = 5.5
    let max: Double = 10.5
    let low: Double = 1.5
    let high: Double = 20.5
    
    XCTAssertEqual(low.within(min...max), min)
    XCTAssertEqual(high.within(min...max), max)
    XCTAssertEqual(min.within(min...max), min)
    XCTAssertEqual(max.within(min...max), max)
  }
  
}
