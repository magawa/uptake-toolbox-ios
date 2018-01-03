import Foundation
import XCTest
import UptakeToolbox



class NegativesTests: XCTestCase {
  func testEmptyCollection() {
    let empty: [Int] = []
    XCTAssert(empty.isEmpty)
    XCTAssertFalse(empty.isNotEmpty)
    
    let full: [Int] = [1,2,3]
    XCTAssertFalse(full.isEmpty)
    XCTAssert(full.isNotEmpty)
  }
  
  
  func testEmptyString() {
    let empty: String = ""
    XCTAssert(empty.isEmpty)
    XCTAssertFalse(empty.isNotEmpty)
    
    let full: String = "foo"
    XCTAssertFalse(full.isEmpty)
    XCTAssert(full.isNotEmpty)
  }
  
  func testContainsWithPredicate() {
    let subject = [1,2,3]
    XCTAssert(subject.contains { $0 == 2 })
    XCTAssertFalse(subject.doesNotContain { $0 == 2 })
    XCTAssertFalse(subject.contains { $0 == 4 })
    XCTAssert(subject.doesNotContain { $0 == 4 })
  }
  
  
  func testContainsWithElement() {
    let subject = [1,2,3]
    XCTAssert(subject.contains(2))
    XCTAssertFalse(subject.doesNotContain(2))
    XCTAssertFalse(subject.contains(4))
    XCTAssert(subject.doesNotContain(4))
  }
  
  
  func testContainsWithString() {
    let subject = "Hello"
    XCTAssert(subject.contains("ell"))
    XCTAssertFalse(subject.doesNotContain("ell"))
    XCTAssertFalse(subject.contains("foo"))
    XCTAssert(subject.doesNotContain("foo"))
  }
}
