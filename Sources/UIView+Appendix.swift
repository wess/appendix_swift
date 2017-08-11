//
//  UIView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2017 Wess Cope. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

func RadiansFromDegrees(degrees:Float) -> Float {
  return degrees * Float(Double.pi) / 180
}

public extension UIView {
  public var origin:CGPoint {
    get {
      return self.frame.origin
    }
    
    set {
      var frame       = self.frame
      frame.origin    = newValue
      self.frame      = frame
    }
  }
  
  public var size:CGSize {
    get {
      return self.frame.size
    }
    
    set {
      var frame   = self.frame
      frame.size  = newValue
      self.frame  = frame
    }
  }
  
  public var width:CGFloat {
    get {
      return self.frame.width
    }
    
    set {
      var size    = self.size
      size.width  = newValue
      
      var frame   = self.frame
      frame.size  = size
      self.frame  = frame
    }
  }
  
  public var height:CGFloat {
    get {
      return self.frame.height
    }
    
    set {
      var frame           = self.frame
      frame.size.height   = newValue
      
      self.frame = frame
    }
  }
  
  public var top:CGFloat {
    get {
      return self.frame.top
    }
    
    set {
      var origin  = self.origin
      origin.y    = newValue
      
      var frame       = self.frame
      frame.origin    = origin
      self.frame      = frame
    }
  }
  
  public var right:CGFloat {
    get {
      return left + width
    }
    
    set {
      var origin  = self.origin
      origin.x    = newValue - self.width
      
      var frame       = self.frame
      frame.origin    = origin
      self.frame      = frame
    }
  }
  
  public var bottom:CGFloat {
    get {
      return top + height
    }
    
    set {
      var origin  = self.origin
      origin.y    = newValue - self.height
      
      var frame       = self.frame
      frame.origin    = origin
      self.frame      = frame
    }
  }
  
  public var left:CGFloat {
    get {
      return self.frame.minX
    }
    
    set {
      var origin  = self.origin
      origin.x    = newValue
      
      var frame       = self.frame
      frame.origin    = origin
      self.frame      = frame
    }
  }
  
  public var cornerRadius:CGFloat {
    get {
      return self.layer.cornerRadius
    }
    
    set {
      self.layer.cornerRadius = newValue
    }
  }
  
  public var borderWidth:CGFloat {
    get {
      return self.layer.borderWidth
    }
    
    set {
      self.layer.borderWidth = newValue
    }
  }
  
  public var borderColor:UIColor {
    get {
      return UIColor(cgColor: self.layer.borderColor!)
    }
    
    set {
      self.layer.borderColor = (newValue as UIColor).cgColor
    }
  }
  
  public var snapshot:UIImage {
    get {
      UIGraphicsBeginImageContextWithOptions(size, true, 0)
      drawHierarchy(in: bounds, afterScreenUpdates: true)
      
      let rasterizedView = UIGraphicsGetImageFromCurrentImageContext()
      
      UIGraphicsEndImageContext()
      
      return rasterizedView!
    }
  }
  
  public var gradientBackgroundColors:[UIColor] {
    get { return [] }
    
    set {
      let gradLayer       = CAGradientLayer()
      gradLayer.colors    = newValue.map { $0.cgColor }
      gradLayer.frame     = bounds
      
      layer.addSublayer(gradLayer)
    }
  }
  
  public func rotate(degrees:Float, duration:TimeInterval, completion:@escaping ((Bool) -> Void)) {
    UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
      self.transform = self.transform.rotated(by: CGFloat(RadiansFromDegrees(degrees: degrees)))
    }, completion: completion)
  }
  
  public func scale(offset:CGPoint, duration:TimeInterval, completion:@escaping ((Bool) -> Void)) {
    UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
      self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
    }, completion: completion)
  }
}












