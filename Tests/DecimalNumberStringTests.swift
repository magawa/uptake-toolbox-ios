import UIKit
import XCTest
import UptakeToolbox



class DecimalNumberStringTests: XCTestCase {
  
  /// Given XCTest's default locale of "en_US", and the similarity between"en_US" and "en_US_POSIX" locales, this test is a little pointless.
  func testPOSIXInit() {
    let subject = NSDecimalNumber(posixString: "1000.001")
    XCTAssertEqual(subject, NSDecimalNumber(mantissa: 1000001, exponent: -3, isNegative: false))
    
    XCTAssertNil(NSDecimalNumber(posixString: "foo"))
  }
  
  
  
  /// Given XCTest's default locale of "en_US", and the similarity between"en_US" and "en_US_POSIX" locales, this test is a little pointless.
  func testPOSIXOutput() {
    let subject = NSDecimalNumber(mantissa: 1000001, exponent: -3, isNegative: false).posixString
    XCTAssertEqual(subject, "1000.001")
    XCTAssertNil(NSDecimalNumber.notANumber.posixString)
  }
  
  
  /// Assumes a default locale of "en_US". Would probably be more interesting in something else.
  func testDisplayInit() {
    print(NSLocale.current)
    let thousandsSubject = NSDecimalNumber(displayString: "100,001.01")
    XCTAssertEqual(thousandsSubject, NSDecimalNumber(mantissa: 10000101, exponent: -2, isNegative: false))
    
    let noThousandsSubject = NSDecimalNumber(displayString: "100001.01")
    XCTAssertEqual(noThousandsSubject, NSDecimalNumber(mantissa: 10000101, exponent: -2, isNegative: false))
    
    XCTAssertNil(NSDecimalNumber(displayString: "NaN"))
  }
  
  
  /// Assumes a default locale of "en_US"
  func testDisplayString() {
    let frenchDecimal = NSDecimalNumber(string: "1100,001", locale: NSLocale(localeIdentifier: "fr_FR"))
    let subject = frenchDecimal.displayString
    XCTAssertEqual(subject, "1,100.001")
  
    XCTAssertNil(NSDecimalNumber.notANumber.displayString)
  }
  
}
