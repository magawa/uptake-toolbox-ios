import Foundation

/// Various error utilities. Because conformance to `Error` is so wide-ranging and rules around bridging to `NSError` are unexpected and unclear, we implement these as top level functions rather than extensions or `Error` or `NSError`.
public enum ErrorHelper {
  
  /**
   Formats any error as a user-readable string. The goal is to use `NSError`'s existing `localizedDescription` machinery when possible. Otherwise we make a best-attempt at types based around `Error` conformance.
   
   - Note: We use whether or not the `userInfo` dictionary is empty to determine if `localizedDescription` should be attemtped. Many other criteria were tried. All failed.
   
   - Parameter error: The error to be formatted for display to users.
   
   - Returns: An error string suitable for display to users. In the case of `NSError` this will be the value of `localizedDescription` (often the value of the `NSLocalizedDescriptionKey` key of `userInfo`). In all other cases we extract the error's domain and append the type's description to it.
   */
  public static func format(_ error: Error) -> String {
    debug? {[
      "FORMAT ERROR-----------------------------",
      "type: \(type(of: error))",
      "domain: \((error as NSError).domain)",
      "code: \((error as NSError).code)",
      "info: \((error as NSError).userInfo)",
      "description: \(error)",
      "localized description: \(error.localizedDescription)",
    ]}
    
    guard (error as NSError).userInfo.isNotEmpty else {
      return "\((error as NSError).domain): \(error)"
    }
    return error.localizedDescription
  }
}
