import Foundation



public extension URL {
  /// Just like `init?(string:)`, except the parameter is optional and the receiver will return `nil` if the parameter is `nil`.
  init?(maybeString: String?) {
    guard let someString = maybeString else {
      return nil
    }
    self.init(string: someString)
  }
}



public extension RawRepresentable {
  /// Just like `init?(rawValue:)`, except the parameter is optional and the receiver will return `nil` if the parameter is `nil`.
  init?(maybeRawValue: RawValue?) {
    guard let someValue = maybeRawValue else {
      return nil
    }
    self.init(rawValue: someValue)
  }
}
