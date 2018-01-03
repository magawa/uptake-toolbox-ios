import Foundation


/**
 Type for matching `NSError`s by domain and code in `case` statements. For example:
 
 ```
 switch myError {
 case ErrorMatcher.urlDomain(NSURLErrorCannotFindHost):
   //handle bad URL...

 case ErrorMatcher.urlDomain(NSURLErrorTimedOut):
   //handle timeout...
 }
 ```
*/
public struct ErrorMatcher {
  /// Domain to match against.
  public let domain: String
  
  /// Code to match against.
  public let code: Int
  
  /// Convenience initializer for the `NSURLErrorDomain`.
  public static func urlDomain(_ code: Int) -> ErrorMatcher {
    return ErrorMatcher(domain: NSURLErrorDomain, code: code)
  }
}



/// Enables matching of `Error` by `ErrorMatcher`.
public func ~=(pattern: ErrorMatcher, value: Error) -> Bool {
  return (value as NSError).domain == pattern.domain && (value as NSError).code == pattern.code
}
