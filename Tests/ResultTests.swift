import UIKit
import XCTest
import UptakeToolbox



class ResultTests: XCTestCase {
  let errorref = NSError(domain: "foo", code: 500, userInfo: [NSLocalizedDescriptionKey: "error value"])
  
  
  func testFailure() {
    let subject = Result<Any>.failure(errorref)
    guard case .failure(let e) = subject else {
      XCTFail()
      return
    }
    XCTAssertEqual((e as NSError).code, errorref.code)
  }
  
  
  func testSuccess() {
    let subject = Result.success("foo")
    guard case .success(let s) = subject else {
      XCTFail()
      return
    }
    XCTAssertEqual(s, "foo")
  }
  
  
  func testDescription() {
    let successSubject = Result.success("success value")
    let failureSubject = Result<Any>.failure(errorref)
    
    XCTAssertEqual(String(describing: successSubject), "success value")
    XCTAssertEqual(String(describing: failureSubject), errorref.localizedDescription)
  }
  
  
  func testBindOverSuccessToSuccess() {
    let original = Result.success(42)
    
    let subject = original.flatMap {
      return .success("number: \($0)")
    }
    
    guard case .success(let v) = subject else {
      XCTFail()
      fatalError("asdf")
    }
    
    XCTAssertEqual(v, "number: 42")
  }
  
  
  func testBindOverSuccessToFailure() {
    let original = Result.success(42)
    
    let subject: Result<Any> = original.flatMap { _ in
      return .failure(errorref)
    }
    
    guard case .failure(let e) = subject else {
      XCTFail()
      return
    }
    
    XCTAssertEqual((e as NSError).code, errorref.code)
  }
  
  
  func testBindOverFailure() {
    let original = Result<Any>.failure(errorref)
    
    let subject = original.flatMap { _ in
      return .success("Never seen")
    }
    
    guard case .failure(let e) = subject else {
      XCTFail()
      return
    }
    
    XCTAssertEqual((e as NSError).code, errorref.code)
  }
  
  
  func testBindOverNewFailure() {
    let original = Result<Any>.failure(errorref)
    
    let subject: Result<Any> = original.flatMap { _ in
      return .failure(NSError(domain: "Never seen", code: 600, userInfo: nil))
    }
    
    guard case .failure(let e) = subject else {
      XCTFail()
      return
    }
    
    XCTAssertEqual((e as NSError).code, errorref.code)
  }
}























