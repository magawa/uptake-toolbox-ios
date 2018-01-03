import Foundation



private let posixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
private let formatter: NumberFormatter = {
  return given(NumberFormatter()) {
    $0.numberStyle = .decimal
    $0.generatesDecimalNumbers = true
  }
}()



/// POSIX defines a format representing decimal numbers as strings on a computer. This is often used by servers and backends as a floating-point- and locale-agnostic way to store decimals. This extends `NSDecimalNumber` with POSIX-aware convenience methods.
public extension NSDecimalNumber {
  
  
  /** 
   Intializes a new `NSDecimalNumber` with the value represented by `posixString`.
   
   - Parameter posixString: A POSIX-formatted string representation of a decimal number.
   
   - Returns: `NSDecimalNumber` instance if `posixString` is a valid decimal as defined by the POSIX format. Otherwise, `nil`.
   */
  convenience init?(posixString: String) {
    let decimal = NSDecimalNumber(string: posixString, locale: posixLocale)
    guard decimal != .notANumber else {
      return nil
    }
    self.init(decimal: decimal.decimalValue)
  }
  
  
  /**
   Intializes a new `NSDecimalNumber` with the value represented by `displayString` in the current locale.
   
   - Note: This differs from `init(string:)` and `init(string:locale:)` in that `displayString` is assumed to be formatted for display. `init(string:)` *et al.* only allow strings with a +, -, decimal seperator, and "e". This uses `NumberFormatter` to be a little more flexible (allowing thousands-seperators, for example).
   
   - Parameter displayString: A string representation of a decimal number in the current locale.
   
   - Returns: `NSDecimalNumber` instance if `displayString` is a valid decimal as defined by the current locale. Otherwise, `nil`.
   */
  convenience init?(displayString: String) {
    guard let decimal = formatter.number(from: displayString) as? NSDecimalNumber else {
      return nil
    }
    self.init(decimal: decimal.decimalValue)
  }
  
  
  /// The value of the receiver as a POSIX-formatted string, or `nil` if receiver is `notANumber`.
  var posixString: String? {
    guard self != .notANumber else {
      return nil
    }
    return description(withLocale: posixLocale)
  }
  
  
  /**
   The value of the receiver as a string formatted for display in the current locale; or `nil` if receiver is `notANumber`.
   
   - Note: This is different from `description(withLocale:)` in that it is intended for display, and thus uses a `NumberFormatter` to format the output. The most obvious change in US locales is the addition of thousands seperators, i.e. "1,000.01".
   */
  var displayString: String? {
    guard self != .notANumber else {
      return nil
    }
    return formatter.string(from: self)
  }
}
