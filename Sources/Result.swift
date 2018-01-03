import Foundation



/**
 A sum type that models either a successful result or a failure (with an error). It also happens to be a monad to help prevent pyramids of doom. There's a useful summary of Results and Swift [here](https://www.cocoawithlove.com/blog/2016/08/21/result-types-part-one.html#using-result-as-a-monad)
 
 - Note: Functional/monadic error handling should be discouraged in Swift whenever possible in favor of `throws`. Until Swift's async language features are nailed down, though (slated for Swift 5 at the moment), there's a gaping hole in async error handling that `throws` can't fill. That's where `Result` fits in.
 */
public enum Result<T> {
  /// Models the successful result of an asynchronous operation.
  case success(T)
  
  
  /// Models the failure of an asynchronous operation (along with its related error).
  case failure(Error)
  
  
  /** 
   Allows us to treat `Result` as a monad. This is a fancy way of saying we can transform a `Result` of one type into another while conserving failures without unwrapping it in a `switch`. In other words, instead of writing:
   
   ```
   func fetchName(completion: (Result<Name>)->Void) {
     fetchPerson { (result: Result<Person>) in
       switch result {
       case .success(let person):
         completion(.success(person.name))
   
       case .failure(let error):
         completion(.failure(error))
       }
     }
   }
   ```
   
   we can write:
   
   ```
   func fetchName(completion: (Result<Name>)->Void) {
     fetchPerson { (result: Result<Person>) in
       completion(result.flatMap { .success($0.name) })
     }
   }
   ```
   
   - Parameter f: A closure that takes the `.success` value of the receiver and transforms it into a new `Result`. `f` will not be evaluated if the receiver is a `.failure`. Instead, `flatMap` will automatically create a new `Result` wrapping the old `.failure` and pass it on.
   
   - Parameter value: The value of the receiver, to be use in the creation of a `Result` of a differnt type.
   
   - Returns: If the receiver is a `.failure`, this passes the failure on wrapped in the new `Result` type. Otherwise, it returns the result of evaluating `f`.
   */
  public func flatMap<U>(transform f: (_ value: T)->Result<U>) -> Result<U> {
    switch self {
    case .success(let t):
      return f(t)
    case .failure(let e):
      return Result<U>.failure(e)
    }
  }
}



extension Result: CustomStringConvertible {
  /// A description of the `Result`; either the string value of a `.success` or the formatted error of a `.failure`.
  public var description: String {
    switch self {
    case .success(let v):
      return String(describing: v)
    case .failure(let e):
      return ErrorHelper.format(e)
    }
  }
}
