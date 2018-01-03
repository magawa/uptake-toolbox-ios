import Foundation


/// Tools to enable reasonably efficient logging in other frameworks.
public enum Logging {
  /// The type of closure evaluated by debug implementations to create the string to log. It's important we use a closure for this (rather than asking for a string, for example) becasue we can choose not to evaluate the closure, thereby saving us cycles when logging is disabled.
  public typealias DebugClosure = ()->[String]
  
  
  /// The type of closure that implements debugging logic.
  public typealias DebugImplementation = (DebugClosure)->Void

  
  /**
   Factory function that sets up debugging implementation in a framework.
   
   - Parameter environmentVariable: The envar to look for to determin whether debugging is enabled or not. If an envar with this name is not `nil`, `setupDebug` returns an actual implementation that will log debug messages. Otherwise, it returns a no-op.
   
   - Parameter prefix: The string to be prefixed to all debugging messages logged by this implementation. Traditionally this is a simple, one character tag exemplifying the framework being logged. Emoji work well for this. For example: "☁️" for the networking library.
   
   - Returns: An optional implementation that can be called to log debugging information. It's important that it's optional, so that when debugging is disabled, we can short circuit with simple optional chaining.
   */
  public static func setupDebug(for environmentVaribale: String, prefix: String) -> DebugImplementation? {
    guard ProcessInfo.processInfo.environment[environmentVaribale] != nil else {
      return nil
    }
    return { (f: DebugClosure) in
      let log = f()
      guard log.isNotEmpty else {
        return
      }
      print(log.map{ prefix + " " + $0 }.joined(separator: "\n"))
    }
  }
}



internal var debug: Logging.DebugImplementation? = Logging.setupDebug(for: "UPTAKE_TOOLBOX_DEBUGGING", prefix: "🛠")


