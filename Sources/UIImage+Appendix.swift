//
//  UIImage+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

public enum UIImageScale {
    case fill
    case aspectFit
    case aspectFill
}

public  extension UIImage {
    public func fill(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let rect = CGRect(origin: .zero, size: size)
        
        color.set()
        UIRectFill(rect)
        
        drawInRect(rect, blendMode: .DestinationIn, alpha: 1)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func crop(to rect:CGRect) -> UIImage {
        let scaled  = CGRect(x: (rect.left * scale), y: (rect.top * scale), width: (rect.width * scale), height:(rect.height * scale))
        let ref     = CGImageCreateWithImageInRect(self.CGImage, scaled)!

        return UIImage(CGImage: ref, scale: scale, orientation: .Up)
    }
  
  
  public func resize(to size:CGSize) -> UIImage? {
    guard let reference = CGImage else { return nil }
    
    let width         = CGImageGetWidth(reference)
    let height        = CGImageGetHeight(reference)
    let referenceSize = CGSize(width: width, height: height)
    
    guard referenceSize == size else { return self }
    
    let ratio       = size.width / referenceSize.width
    var transform   = CGAffineTransformIdentity
    
    switch imageOrientation {
    case .Up:
      transform = CGAffineTransformIdentity
      break
    case .UpMirrored:
      transform = CGAffineTransformMakeTranslation(referenceSize.width, 0)
      transform = CGAffineTransformScale(transform, -1, 1)
      break
    case .Down:
      transform = CGAffineTransformMakeTranslation(referenceSize.width, referenceSize.height)
      transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
      break
    case .DownMirrored:
      transform = CGAffineTransformMakeTranslation(0, referenceSize.height)
      transform = CGAffineTransformScale(transform, 1, -1)
      break
    case .LeftMirrored:
      let sizeFlip  = CGSize(width: size.height, height: size.width)
      transform     = CGAffineTransformMakeTranslation(referenceSize.width, referenceSize.height)
      transform     = CGAffineTransformScale(transform, -1, 0)
      transform     = CGAffineTransformRotate(transform, CGFloat(3.0 * M_PI_2))
      break
    case .Left:
      let sizeFlip  = CGSize(width: size.height, height: size.width)
      transform     = CGAffineTransformMakeTranslation(0, referenceSize.width)
      transform     = CGAffineTransformRotate(transform, CGFloat(3.0 * M_PI_2))
      break
    case .RightMirrored:
      let sizeFlip  = CGSize(width: size.height, height: size.width)
      transform     = CGAffineTransformMakeScale(-1, 1)
      transform     = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
      break
    case .Right:
      let sizeFlip  = CGSize(width: size.height, height: size.width)
      transform     = CGAffineTransformMakeTranslation(referenceSize.height, 0)
      transform     = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
      break
    default:
      return nil
    }
    
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    
    if imageOrientation == .Right || imageOrientation == .Left {
      CGContextScaleCTM(context, -ratio, ratio)
      CGContextTranslateCTM(context, -referenceSize.height, 0)
    } else {
      CGContextScaleCTM(context, ratio, -ratio)
      CGContextTranslateCTM(context, 0, -referenceSize.height)
    }
    
    CGContextConcatCTM(context, transform)
    
    CGContextDrawImage(context, CGRect(origin: .zero, size:referenceSize), reference)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image
  }
  
  public func resizeToFit(in size:CGSize, scaleIfSmaller:Bool) -> UIImage? {
    guard let reference = CGImage else { return nil }
    
    var bounding      = size
    let width         = CGImageGetWidth(reference)
    let height        = CGImageGetHeight(reference)
    let referenceSize = CGSize(width: width, height: height)
    
    switch imageOrientation {
    case .Left, .Right, .LeftMirrored, .RightMirrored:
      bounding = CGSize(width: size.height, height: size.width)
      break
      
    default:
      break
    }
    
    let toSize:CGSize
    if scaleIfSmaller == false && (referenceSize.width < bounding.width) && (referenceSize.height < bounding.height) {
      toSize = referenceSize
    } else {
      let ratio = ((bounding.width / referenceSize.width), (bounding.height / referenceSize.height))
      let width:CGFloat
      let height:CGFloat
      
      if ratio.0 < ratio.1 {
        width   = bounding.width
        height  = CGFloat(floorf(Float(referenceSize.height) * Float(ratio.0)))
      } else {
        width   = CGFloat(floorf(Float(referenceSize.width) * Float(ratio.1)))
        height  = bounding.height
      }
      
      toSize = CGSize(width: width, height: height)
    }
    
    return resize(to: toSize)
  }
}







