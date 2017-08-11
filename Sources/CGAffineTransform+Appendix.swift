
//
//  CGAffineTransform+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2017 Wess Cope. All rights reserved.
//

import Foundation


public func +(left:CGAffineTransform, right:CGAffineTransform) -> CGAffineTransform {
  return left.concat(transform: right)
}

public extension CGAffineTransform {
  var isIdentity:Bool { return self.isIdentity }
  
  public init(a: Double, b: Double, c: Double, d: Double, tx: Double, ty: Double) {
    self.init(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
  }
  
  public init(a: Int, b: Int, c: Int, d: Int, tx: Int, ty: Int) {
    self.init(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
  }
  
  public init(scalex x: CGFloat, y: CGFloat) {
    self.init(a: x, b: 0, c: 0, d: y, tx: 0, ty: 0)
  }
  
  public init(scalex x: Double, y: Double) {
    self.init(scalex: CGFloat(x), y: CGFloat(y))
  }
  
  public init(scalex x: Int, y: Int) {
    self.init(scalex: CGFloat(x), y: CGFloat(y))
  }
  
  public init(translatex x: CGFloat, y: CGFloat) {
    self.init(a: 1, b: 0, c: 0, d: 1, tx: x, ty: y)
  }
  
  public init(translatex x: Double, y: Double) {
    self.init(translatex: CGFloat(x), y: CGFloat(y))
  }
  
  public init(translatex x: Int, y: Int) {
    self.init(translatex: CGFloat(x), y: CGFloat(y))
  }
  
  public init(rotate angle: CGFloat) {
    self.init(a: cos(angle), b: sin(angle), c: -sin(angle), d: cos(angle), tx: 0, ty: 0)
  }
  
  public init(rotate angle: Double) {
    self.init(rotate: CGFloat(angle))
  }
  
  public init(rotate angle: Int) {
    self.init(rotate: CGFloat(angle))
  }
  
  public func translate(x: CGFloat, y: CGFloat) -> CGAffineTransform {
    return self.translatedBy(x: tx, y: ty)
  }
  public func translate(x: Double, y: Double) -> CGAffineTransform {
    return translate(x: CGFloat(x), y: CGFloat(y))
  }
  public func translate(x: Int, y: Int) -> CGAffineTransform {
    return translate(x: CGFloat(x), y: CGFloat(y))
  }
  
  public func scale(x: CGFloat, y: CGFloat) -> CGAffineTransform {
    return self.scaledBy(x: x, y: y)
  }
  
  public func scale(x: Double, y: Double) -> CGAffineTransform {
    return self.scaledBy(x: CGFloat(x), y: CGFloat(y))
  }
  
  public func scale(x: Int, y: Int) -> CGAffineTransform {
    return self.scaledBy(x: CGFloat(x), y: CGFloat(y))
  }
  
  public func rotate(angle: CGFloat) -> CGAffineTransform {
    return self.rotated(by: angle)
  }
  
  public func rotate(angle: Double) -> CGAffineTransform {
    return self.rotated(by: CGFloat(angle))
  }
  
  public func rotate(angle: Int) -> CGAffineTransform {
    return self.rotated(by: CGFloat(angle))
  }
  
  public func invert() -> CGAffineTransform {
    return self.inverted()
  }
  
  public var inverse: CGAffineTransform {
    return invert()
  }
  
  public func concat(transform: CGAffineTransform) -> CGAffineTransform {
    return self.concatenating(transform)
  }
}

extension CGAffineTransform : CustomStringConvertible {
  public var description:String { return NSStringFromCGAffineTransform(self) }
}




