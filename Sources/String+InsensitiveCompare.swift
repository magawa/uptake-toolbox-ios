import Foundation



infix operator *==: ComparisonPrecedence



/// Used to compare two strings when sensitivity doesn't matter. Specifically, case, diacritics and width aren't checked. Thus the following are all true:
///
///  ```
///  "foo" *== "FOO"
///  "foo" *== "föö"
///  "foo" *== "fｏｏ"
///  ```
public func *==(lhs: String?, rhs: String?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l.insensitiveCompare(r) == .orderedSame
    case (nil, nil):
        return true
    case (nil, _), (_, nil):
        return false
    }
}



public extension String {
    
    
    /// Used to compare another string to the receiver when sensitivity doesn't matter. Specifically, case, diacritics and width aren't checked. Thus the following are all return `.orderedSame`:
    ///
    ///  ```
    ///  "foo".insensitiveCompare("FOO")
    ///  "foo".insensitiveCompare("föö")
    ///  "foo".insensitiveCompare("fｏｏ")
    ///  ```
    func insensitiveCompare(_ other: String) -> ComparisonResult {
        return self.compare(other, options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive])
    }
}
