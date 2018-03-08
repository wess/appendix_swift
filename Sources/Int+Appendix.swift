//
//  Int+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension Int {
  public var isEven:Bool      { return (self % 2 == 0) }
  public var double:Double    { return Double(self) }
  public var float:Float      { return Float(self) }
  
  public static func random(_ length:Int = 4) -> Int {
    return Int(
      arc4random_uniform(UInt32(length))
    )
  }
}






