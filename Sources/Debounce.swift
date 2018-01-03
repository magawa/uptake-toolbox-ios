import Foundation



/**
 Performs a task only after some given threshold of time has passed without another request to perform the task. Once the task is performed, there's an optional, configurable refractory period during which requests to perform the task are ignored.
 */
public class Debounce {
  private let threshold: TimeInterval
  private let refractoryPeriod: TimeInterval?
  weak private var timer: Timer?
  private var isRefractory: Bool = false
  private let handler: ()->Void
  
  
  /**
   Initializes the debounce. Keep a reference to this and call `requestPerformance()` on it to request the given closure be called after threshold expires.
   
   - parameter threshold: The amount of time that has to pass after a call to `requestPerformance()` without interruption by subsequent calls to `requestPerformance()` for `perform` to be executed.
   
   - parameter refractoryPeriod: *Optional.* The amount of time after a successful execution of `perform` during which all calls to `requestPerformance()` are ignored.
   
   - parameter perform: The closure to execute after `threshold` time has passed after a `requestPerformace()` call without any intervening `requestPerformance()` calls.
   */
  public init(threshold: TimeInterval, refractoryPeriod: TimeInterval? = 1, perform: @escaping ()->Void) {
    self.threshold = threshold
    self.refractoryPeriod = refractoryPeriod
    handler = perform
  }
  
  
  deinit {
    timer?.invalidate()
  }
}



public extension Debounce {
  /// Call this method to request the handler be executed. Calling this method sets up a timer that will execute the handler after a threshold. If this method is called again before the timer expires, it invalidates it and sets up a new one. Thus, the handler will only be called after threshold time has passed between calls to this method.
  func requestPerformance() {
    timer?.invalidate()
    
    guard isRefractory == false else {
      return
    }
    
    resetTimer()
  }
}



private extension Debounce {
  func resetTimer() {
    let strongTimer = Timer(timeInterval: threshold, target: self, selector: #selector(debounceFire), userInfo: nil, repeats: false)
    RunLoop.current.add(strongTimer, forMode: .commonModes)
    timer = strongTimer
  }
  
  
  @objc func debounceFire() {
    handler()
    enterRefractoryPeriod()
  }
  
  
  func enterRefractoryPeriod() {
    // If `refractoryPeriod` is nil, we never enter a refrectory mode and `requestPerformance()` will continute to trigger events.
    guard let interval = refractoryPeriod else {
      return
    }
    self.isRefractory = true
    let refractoryTimer = Timer(timeInterval: interval, target: self, selector: #selector(refractoryFire), userInfo: nil, repeats: false)
    RunLoop.current.add(refractoryTimer, forMode: .commonModes)
  }
  
  
  @objc func refractoryFire() {
    isRefractory = false
  }
}

