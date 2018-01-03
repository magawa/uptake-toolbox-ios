import UIKit
import XCTest
import UptakeToolbox



class MaybeInitializersTests: XCTestCase {
  func testMaybeURL() {
    XCTAssertNotNil(URL(maybeString: "example.com"))
    XCTAssertNil(URL(maybeString: nil))
  }
  
  
  func testMaybeRawEnum() {
    enum Subject: Int {
      case one = 1, two, three
    }
    
    XCTAssertNotNil(Subject(maybeRawValue: 1))
    XCTAssertNil(Subject(maybeRawValue: nil))
  }
}
