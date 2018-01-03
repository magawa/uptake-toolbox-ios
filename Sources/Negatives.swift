import Foundation



extension Collection {
  ///The opposite of `isEmpty`.
  public var isNotEmpty: Bool{
    return ❗️isEmpty
  }
  
  
  ///The opposite of `contains(where:)`.
  public func doesNotContain(where predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
    let success = try contains(where: predicate)
    return ❗️success
  }
}



extension Sequence where Iterator.Element : Equatable {
  ///The opposite of `contains(_:)`.
  public func doesNotContain(_ element: Self.Iterator.Element) -> Bool {
    return ❗️contains(element)
  }
}



extension String{
  ///The opposite of `isEmpty`.
  public var isNotEmpty:Bool{
    return ❗️isEmpty
  }
  
  
  ///The opposite of `contains(_:)`.
  public func doesNotContain(_ other: String) -> Bool {
    return ❗️self.contains(other)
  }
}
