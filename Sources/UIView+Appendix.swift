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
            return CGRectGetWidth(self.frame)
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
            return CGRectGetHeight(self.frame)
        }
        
        set {
            var size    = self.size
            size.height = newValue
            
            var frame   = self.frame
            frame.size  = self.size
            self.frame  = frame
        }
    }
    
    public var top:CGFloat {
        get {
            return CGRectGetMinY(self.frame)
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
            return CGRectGetMinX(self.frame)
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
            return UIColor(CGColor: self.layer.borderColor!)
        }
        
        set {
            self.layer.borderColor = (newValue as UIColor).CGColor
        }
    }
    
    public var snapshot:UIImage {
        get {
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
            
            let rasterizedView = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return rasterizedView
        }
    }
    
    public var gradientBackgroundColors:[UIColor] {
        get { return [] }

        set {
            var colors = [CGColor]()
            newValue.each { index, element in
                colors.append(element.CGColor)
            }
            
            let gradLayer       = CAGradientLayer()
            gradLayer.colors    = colors
            gradLayer.frame     = bounds
            
            layer.addSublayer(gradLayer)
        }
    }
    
    public func rotate(degrees:Float, duration:NSTimeInterval, completion:((Bool) -> Void)) {
        UIView.animateWithDuration(duration, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.transform = CGAffineTransformRotate(self.transform, CGFloat(RadiansFromDegrees(degrees)))
        }, completion: completion)
    }
    
    public func scale(offset:CGPoint, duration:NSTimeInterval, completion:((Bool) -> Void)) {
        UIView.animateWithDuration(duration, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.transform = CGAffineTransformScale(self.transform, offset.x, offset.y)
        }, completion: completion)
    }
}












