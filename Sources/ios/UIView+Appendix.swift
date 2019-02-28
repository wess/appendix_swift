//
//  UIView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

func RadiansFromDegrees(degrees:Float) -> Float {
  return degrees * Float(M_PI) / 180
}

public enum UIViewCorner {
  case topLeft
  case topRight
  case bottomLeft
  case bottomRight

  public static let all:[UIViewCorner] = [.topLeft, .topRight, .bottomLeft, .bottomRight]
  
  var mask:CACornerMask {
    switch self {
    case .topLeft:
      return CACornerMask.layerMinXMinYCorner
    case .topRight:
      return CACornerMask.layerMinXMaxYCorner
    case .bottomLeft:
      return CACornerMask.layerMaxXMinYCorner
    case .bottomRight:
      return CACornerMask.layerMaxXMinYCorner
    }
  }
}

@available(iOS 11.0, *)
public extension UIView {
  /// Shortcut to the frame's origin.
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
  
  /// Shortcut to the frame's size.
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
  
  /// Shortcut to the frame's width.
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
  
  /// Shortcut to the frame's height.
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
  
  /// Shortcut to the frame's top.
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
  
  /// Shortcut to the frame's right.
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
  
  /// Shortcut to the frame's bottom.
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
  
  /// Shortcut to the frame's left.
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
  
  /// Shortcut to the layer's corner radius.
  public var cornerRadius:CGFloat {
    get {
      return self.layer.cornerRadius
    }
    
    set {
      self.clipsToBounds      = newValue > 0
      self.layer.cornerRadius = newValue
    }
  }
  
  public var roundedCorners:[UIViewCorner] {
    get {
      var corners:[UIViewCorner] = []
      
      if layer.maskedCorners.contains(.layerMinXMinYCorner) {
        corners.append(.topLeft)
      }
      
      if layer.maskedCorners.contains(.layerMaxXMinYCorner) {
        corners.append(.topRight)
      }
      
      if layer.maskedCorners.contains(.layerMinXMaxYCorner) {
        corners.append(.bottomLeft)
      }

      if layer.maskedCorners.contains(.layerMaxXMaxYCorner) {
        corners.append(.bottomRight)
      }

      return corners
    }
    
    set {
      layer.maskedCorners = newValue.reduce(CACornerMask()) { CACornerMask(rawValue: $0.rawValue << $1.mask.rawValue) }
    }
  }
  
  /// Shortcut to the layer's border width.
  public var borderWidth:CGFloat {
    get {
      return self.layer.borderWidth
    }
    
    set {
      self.layer.borderWidth = newValue
    }
  }
  
  /// Shortcut to the layer's border color.
  public var borderColor:UIColor {
    get {
      return UIColor(cgColor: self.layer.borderColor!)
    }
    
    set {
      self.layer.borderColor = (newValue as UIColor).cgColor
    }
  }

  /// Shortcut to the layer's shadow opacity.
  public var shadowOpacity:CGFloat {
    get {
      return CGFloat(self.layer.shadowOpacity)
    }
    
    set {
      self.layer.shadowOpacity = Float(newValue)
    }
  }
  
  /// Shortcut to the layer's shadow color.
  public var shadowColor:UIColor? {
    get {
      return self.layer.shadowColor == nil ? UIColor(cgColor: self.layer.shadowColor!) : nil
    }
    
    set {
      self.layer.shadowColor = newValue == nil ? nil : newValue!.cgColor
    }
  }

  /// Shortcut to the layer's shadow offset.
  public var shadowOffset:CGSize {
    get {
      return self.layer.shadowOffset
    }
    
    set {
      self.layer.shadowOffset = newValue
    }
  }
  
  /// Shortcut to the layer's shadow radius.
  public var shadowRadius:CGFloat {
    get {
      return self.layer.shadowRadius
    }
    
    set {
      self.layer.shadowRadius = newValue
    }
  }
  
  /// Shortcut to the layer's shadow path.
  public var shadowPath:CGPath? {
    get {
      return self.layer.shadowPath
    }
    
    set {
      self.layer.shadowPath = newValue
    }
  }
  
  /// UIImage representation of the view.
  public var snapshot:UIImage {
    get {
      UIGraphicsBeginImageContextWithOptions(size, true, 0)
      drawHierarchy(in: bounds, afterScreenUpdates: true)
      
      let rasterizedView = UIGraphicsGetImageFromCurrentImageContext()
      
      UIGraphicsEndImageContext()
      
      return rasterizedView!
    }
  }
  
  /// Set to make view background gradient.
  public var gradientBackgroundColors:[UIColor] {
    get { return [] }
    
    set {
      let gradLayer       = CAGradientLayer()
      gradLayer.colors    = newValue.map { $0.cgColor }
      gradLayer.frame     = bounds
      
      layer.addSublayer(gradLayer)
    }
  }
  
  /**
   Animate the rotation of the view.
   
   - parameter degrees: Amount to rotate the view by.
   - parameter duration: How long animation will run.
   - parameter completion: Block called when the animation is complete.
  */
  public func rotate(degrees:Float, duration:TimeInterval, completion:@escaping ((Bool) -> Void)) {
    UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
      self.transform = self.transform.rotated(by: CGFloat(RadiansFromDegrees(degrees: degrees)))
    }, completion: completion)
  }
  
  /**
   Animate the scaling of the view.
   
   - parameter offset: Amount to scale the view by.
   - parameter duration: How long animation will run.
   - parameter completion: Block called when the animation is complete.
   */
  public func scale(offset:CGPoint, duration:TimeInterval, completion:@escaping ((Bool) -> Void)) {
    UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
      self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
    }, completion: completion)
  }
  
  /**
   Add multiple views, as subviews.
   
   - parameter subviews: Array of views to add.
   - returns: Current view instance.
  */
  @discardableResult
  public func addSubviews(_ subviews:[UIView]) -> UIView {
    subviews.forEach(addSubview)
    
    return self
  }

  /**
   Add multiple views, as subviews.
   
   - parameter args: Comma separated list of views (as arguments) to add.
   - returns: Current view instance.
   */
  @discardableResult
  public func addSubviews(_ args:UIView...) -> UIView {
    args.forEach(addSubview)
    
    return self
  }
  
  /**
   Adds view instance, as a subview, to another view.
   
   - parameter to: View to add view instance to
   - returns: Current view instance.
  */
  @discardableResult
  public func add(to: UIView) -> UIView {
    to.addSubview(self)
    
    return self
  }
  
  /**
   Cycles layout, forcing call to `layout`.
   
   - returns: Current view instance.
  */
  @discardableResult
  public func cycleLayout() -> UIView {
    self.setNeedsLayout()
    self.layoutIfNeeded()
    
    return self
  }
  
  /**
   Cycles constraints, forcing call to `updateConstraints`.
   
   - returns: Current view instance.
  */
  @discardableResult
  public func cycleConstraints() -> UIView {
    self.setNeedsUpdateConstraints()
    self.updateConstraintsIfNeeded()
    
    return self
  }
}

fileprivate struct UIViewAnimationDefaults {
  static let Duration:TimeInterval  = 1
  static let Damping:CGFloat        = 0.5
  static let Velocity:CGFloat       = 0.5
}

extension UIView /* Animations */ {
  /**
   Animates shaking with view (left and right).
   
   - parameter times: Number of times view should shake.
   - returns: Current view instance.
  */
  @discardableResult
  public func shake(_ times:Int) -> UIView {
    let keyframe          = CAKeyframeAnimation(keyPath: "transform")
    keyframe.autoreverses = true
    keyframe.repeatCount  = Float(times)
    keyframe.duration     = 7/100
    
    keyframe.values = [
      NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
      NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
    ]
    
    self.layer.add(keyframe, forKey: nil)
    
    return self
  }
  
  /**
   Animates springing with view.
   
   - parameter animations: Block used for changing properties of the view during animation.
   - parameter completion: Block called when the animation is complete.
   - returns: Current view instance.
  */
  @discardableResult
  public func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) -> UIView {
    return spring(duration: UIViewAnimationDefaults.Duration, animations: animations, completion: completion)
  }
  
  
  /**
   Animates springing with view.
   
   - parameter duration: How long animation will run.
   - parameter animations: Block used for changing properties of the view during animation.
   - parameter completion: Block called when the animation is complete.
   - returns: Current view instance.
   */
  @discardableResult
  public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) -> UIView {
    UIView.animate(
      withDuration:  UIViewAnimationDefaults.Duration,
      delay: 0,
      usingSpringWithDamping: UIViewAnimationDefaults.Damping,
      initialSpringVelocity:  UIViewAnimationDefaults.Velocity,
      options: UIView.AnimationOptions.allowAnimatedContent,
      animations: animations,
      completion: completion
    )
    
    return self
  }

}
