//
//  CGRect+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public extension CGPoint {
  public init(_ x: CGFloat, _ y: CGFloat) {
    self.x = x
    self.y = y
  }
  
  public func with(x:CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
  }
  
  public func with(y:CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
  }
}

public extension CGRect {
  public var x:CGFloat {
    get { return origin.x }
    set { origin.x = newValue }
  }
  
  public var y:CGFloat {
    get { return origin.y }
    set { origin.y = newValue }
  }
  
  public var top:CGFloat {
    get { return y }
    set { y = newValue }
  }
  
  public var right:CGFloat {
    get { return x + width }
    set { x = newValue - width }
  }
  
  public var bottom:CGFloat {
    get { return y + height }
    set { y = newValue - height }
  }
  
  public var left:CGFloat {
    get { return x }
    set { x = newValue }
  }
  
  public var centerX:CGFloat {
    get { return x + width * 0.5  }
    set { x = newValue - width * 0.5 }
  }
  
  public var centerY:CGFloat {
    get { return y + width * 0.5 }
    set { y = newValue - width * 0.5 }
  }
  
  public var center:CGPoint {
    get { return CGPoint(x, y) }
    set {
      centerX = newValue.x
      centerY = newValue.y
    }
  }
}



