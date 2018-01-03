import Foundation



public extension Int {
  /**
   - Parameter range: The range to constrain the receiver to.
   
   - Returns: A copy of the receiver constrained to the given range.
   */
  func within(_ range: ClosedRange<Int>) -> Int {
    return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
  }
}



public extension Float {
  /**
   - Parameter range: The range to constrain the receiver to.
   
   - Returns: A copy of the receiver constrained to the given range.
   */
  func within(_ range: ClosedRange<Float>) -> Float {
    return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
  }
}



public extension Double {
  /**
   - Parameter range: The range to constrain the receiver to.
   
   - Returns: A copy of the receiver constrained to the given range.
   */
  func within(_ range: ClosedRange<Double>) -> Double {
    return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
  }
}
