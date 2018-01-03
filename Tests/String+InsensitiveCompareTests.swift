import Foundation
import XCTest
import UptakeToolbox


class StringInsensitiveCompareTests: XCTestCase {
    func testCaseInsensitive() {
        behavesInsensitively(subject: "FOO", expected: "foo")
    }
    
    
    func testDiacritic() {
        behavesInsensitively(subject: "föo", expected: "foo")
    }
    
    
    func testWidth() {
        behavesInsensitively(subject: "fｏo", expected: "foo")
    }

    
    func testNegative() {
        XCTAssertFalse("foo" *== "bar")
        XCTAssertFalse("foo" *== nil)
        XCTAssertFalse(nil *== "bar")

        XCTAssertEqual("foo".insensitiveCompare("bar"), .orderedDescending)
    }
    
    
    func testOptionalOperator() {
        XCTAssert(nil *== nil)
    }
}


extension StringInsensitiveCompareTests {
    private func behavesInsensitively(subject: String, expected: String, file: StaticString = #file, line: UInt = #line) {
        let optionalSubject: String? = subject
        let optionalExpected: String? = expected
        
        XCTAssert(subject *== expected, file: file, line: line)
        XCTAssert(expected *== subject, file: file, line: line)
        XCTAssert(optionalSubject *== optionalExpected, file: file, line: line)
        XCTAssert(optionalExpected *== optionalSubject, file: file, line: line)

        XCTAssertEqual(subject.insensitiveCompare(expected), .orderedSame, file: file, line: line)
        XCTAssertEqual(expected.insensitiveCompare(subject), .orderedSame, file: file, line: line)
    }
}
