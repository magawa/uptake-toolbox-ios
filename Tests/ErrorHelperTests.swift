import UIKit
import XCTest
import UptakeToolbox


fileprivate enum MyError: Error {
  case simple
  case argument(Int)
  case multipleArgument(Int, String)
}


class ErrorHelperTests: XCTestCase {

  func testErrorFormat() {
    let simpleSubject = ErrorHelper.format(MyError.simple)
    XCTAssert(simpleSubject.contains("MyError in"))
    XCTAssert(simpleSubject.contains(": simple"))
    
    let argumentSubject = ErrorHelper.format(MyError.argument(404))
    XCTAssert(argumentSubject.contains("MyError in"))
    XCTAssert(argumentSubject.contains(": argument(404)"))
    
    let multiSubject = ErrorHelper.format(MyError.multipleArgument(404, "not found"))
    XCTAssert(multiSubject.contains("MyError in"))
    XCTAssert(multiSubject.contains(": multipleArgument(404, \"not found\")"))
  }
  
  
  func testNSErrorFormat() {
    let domain = "some domain"
    let code = 500
    let error = NSError(domain: domain, code: code, userInfo: ["foo": "bar"])
    
    XCTAssertEqual(ErrorHelper.format(error), "The operation couldn’t be completed. (\(domain) error \(code).)")
  }
  
  
  func testLocalizedNSErrorFormat() {
    let description = "Some localized description."
    let error = NSError(domain: "none", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
    
    XCTAssertEqual(ErrorHelper.format(error), description)
  }
}
