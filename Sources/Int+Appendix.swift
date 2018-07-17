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
  
  public func times(_ closure:() -> Void) {
    guard self > 0 else { return }
    
    for _ in 0..<self {
      closure()
    }
  }
}
