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

internal extension UIImage {
    func fill(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let rect = CGRect(origin: .zeroPoint, size: size)
        
        color.set()
        UIRectFill(rect)
        
        drawInRect(rect, blendMode: .DestinationIn, alpha: 1)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func crop(to rect:CGRect) -> UIImage {
        let scaled  = CGRect(x: (rect.left * scale), y: (rect.top * scale), width: (rect.width * scale), height:(rect.height * scale))
        let ref     = CGImageCreateWithImageInRect(self.CGImage, scaled)!

        return UIImage(CGImage: ref, scale: scale, orientation: .Up)
    }
    
    
}