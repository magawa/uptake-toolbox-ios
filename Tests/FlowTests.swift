import UIKit
import XCTest
import UptakeToolbox



class FlowTests: XCTestCase {
  func testGivenExecutes() {
    let executed = expectation(description: "should exectue")
    _ = given(UIView()) { _ in
      executed.fulfill()
    }
    wait(for: [executed], timeout: 1)
  }
  
  
  func testGivenReference() {
    let subject = given(UIView()) {
      $0.tag = 1024
    }
    XCTAssertEqual(subject.tag, 1024)
  }
  
  
  func testGivenRetainsInScope() {
    let strongView = UIView()
    weak var subject: UIView?
    
    subject = UIView()
    XCTAssertNil(subject)
    
    subject = given(UIView()) {
      strongView.addSubview($0)
    }
    XCTAssertNotNil(subject)
  }
  

  func testGivenThrows() {
    enum MyError: Error {
      case Foo
    }
    
    class Foo {
      func foo() throws -> Void {
        throw MyError.Foo
      }
    }
    
    let expectedError = expectation(description: "Waiting for error")
    
    do {
      let _ = try given(Foo()) {
        try $0.foo()
      }
    } catch MyError.Foo {
      expectedError.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedError], timeout: 1)
  }
  
  
  func testWith() {
    let exectued = expectation(description: "Should execute")
    
    with("foo") {
      XCTAssertEqual($0, "foo")
      exectued.fulfill()
    }
    
    wait(for: [exectued], timeout: 1)
  }
  
  
  func testWithThrows() {
    enum MyError: Error {
      case Foo
    }
    
    struct Foo {
      func foo() throws -> Void {
        throw MyError.Foo
      }
    }
    
    let expectedError = expectation(description: "Waiting for error")
    
    do {
      try with(Foo()) {
        try $0.foo()
      }
    } catch MyError.Foo {
      expectedError.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedError], timeout: 1)
  }
}
