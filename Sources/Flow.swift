import Foundation



/**
 Given an `object` and a closure, `f`, this evaluates `f(object)`, returning `object` when done.
 
 When `object` is a reference type, this essentially creates an anonymous variable scoped to `f` that escapes the scope after evaluation by being returned by `given`. This has a few uses.
 
 If you find youreself setting up a temp variable only to manipulate it before passing it along to some other operation, `given` can clean that up. So:
 
 ```
 func makeModel() -> Model {
   let newModel = Model()
   newModel.name = "Default"
   newModel.color = .blue
   return newModel
 }
 ```
 
 could be rewritten as:
 
 ```
 func makeModel() -> Model {
   return given(Model()) {
     $0.name = "Default"
     $0.color = .blue
   }
 }
 ```
 
 We can also use `given` to resolve life-cycle annoyances. For example:
 
 ```
   weak var weakView: UIView?
   //...
   let tmpView = UIView()
   weakView = tmpView
   addSubview(tmpView)
 ```
 
 Here our view isn't retained by anything until it's passed to `addSubview(_:)`. If we didn't have tmpView holding on to it, it would be immediately deallocated. But everything passed to `given` is retained until its closure returns, so we could:
 
 ```
 weak var weakView: UIView?
 //...
 weakView = given(UIView()) {
   addSubview($0)
 }
 ```
 
 - Warning: Types with value semantics get copied when passed in to and returned from closures, so it's pointless to use them with `given` (the value you pass in will always be the same as the value returned). `with` is usually a better fit in these cases.
 
 - SeeAlso: `with(_:do:)`
 
 - Parameter object: The object to be passed to `f` and ultimately returned from `given`. This should really be a reference type.
 
 - Parameter f: The closure to evaluate in the context of `object`.
 
 - Parameter obj: `object`, as passed to `f`.
 
 - Returns: `object`, having been manipulated by `f`.
 */
public func given<T>(_ object:T, with f: (_ obj: T) throws -> Void) rethrows -> T where T: AnyObject {
  try f(object)
  return object
}



/**
 Given an `object` and a closure `f`, this evaluates `f(object)`… and that's all! Really, `given(_:with:)` is the more interesting one.
 
 But like `given`, `with` still creates an pseudo-anonymous variable scoped to `f` and passed to it as its only parameter. Unlike `given`, though, this parameter will never escape `f`. So `with` is mostly useful for queuing up side effects with/on the parameter, not manipulating it. Still, this can elimitate tmp variable management and save some typing. For example:
 
 ```
 let tmpnc = NotificationCenter.default
 tmpnc.addObserver(...)
 tmpnc.addObserver(...)
 tmpnc.addObserver(...)
 /// «tmpnc» now hangs around
 ```
 
 can be written:
 
 ```
 with(NotificationCenter.default) {
   $0.addObserver(...)
   $0.addObserver(...)
   $0.addObserver(...)
 }
 ```
 
 - Warning: While `with` can be passed a reference type that's strongly held elsewhere and thus manupulate state ourside of `f`, that's really not what it's for. You should look into using `given` instead.
 
 - SeeAlso: `given(_:with:)`
 
 - Parameter object: The object to be passed to `f`.
 
 - Parameter f: The closure to evaluate in the context of `object`.
 
 - Parameter obj: `object`, as passed to `f`.
 */
public func with<T>(_ object: T, do f: (_ obj: T) throws -> Void) rethrows {
  try f(object)
}
