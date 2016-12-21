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

public  extension UIImage {
  public func fill(color:UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let rect = CGRect(origin: .zero, size: size)
    
    color.set()
    UIRectFill(rect)
    
    draw(in: rect, blendMode: .destinationIn, alpha: 1)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
  
  public func crop(to rect:CGRect) -> UIImage {
    let scaled  = CGRect(x: (rect.left * scale), y: (rect.top * scale), width: (rect.width * scale), height:(rect.height * scale))
    let ref     = self.cgImage!.cropping(to: scaled)!
    
    return UIImage(cgImage: ref, scale: scale, orientation: .up)
  }
}
