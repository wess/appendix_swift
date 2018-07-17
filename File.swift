//
//  File.swift
//  Appendix
//
//  Created by Wess Cope on 7/17/18.
//

import Foundation

extension TimeInterval {
  
  internal struct Seconds {
    static var perDay:Double        { return 24 * 60 * 60 }
    static var perHour:Double       { return 60 * 60 }
    static var perMinute:Double     { return 60 }
    static var milliseconds:Double  { return 1_000 }
    static var microseconds:Double  { return 1_000 * 1_000 }
    static var nanoseconds:Double   { return 1_000 * 1_000 * 1_000 }
  }
  
  public var days:Double {
    return self / Seconds.perDay
  }
  
  public var hours:Double {
    return self / Seconds.perHour
  }
  
  public var minutes:Double {
    return self / Seconds.perMinute
  }
  
  public var seconds:Double {
    return self
  }
  
  public var milliseconds:Double {
    return self * Seconds.milliseconds
  }
  
  public var microseconds:Double {
    return self * Seconds.milliseconds
  }
  
  public var nanoseconds:Double {
    return self * Seconds.nanoseconds
  }
}


