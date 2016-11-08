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

    public func scale(to size:CGSize, mode:UIImageScale = .aspectFit) -> UIImage? {
        let ratio = ((size.width / self.size.width), (size.height / self.size.height))
        let scale:CGFloat 

        switch mode {
            case .fill:
            scale = 1
            break 

            case .aspectFit:
            scale = min(ratio.0, ratio.1)
            break 

            case .aspectFill:
            scale = max(ratio.0, ratio.1)
            break 
        }

        let width       = size.width * scale 
        let height      = size.height * scale 
        let rect        = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        let space       = CGColorSpaceCreateDeviceRGB()
        let bitmap      = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let transform   = CGAffineTransform.identity

        guard let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue),
              let cgImage = self.cgImage else {
            return self
        }

        context.concatenate(transform)
        
        context.interpolationQuality = CGInterpolationQuality(rawValue: 3)

        context.draw(cgImage, in: rect)

        guard let contextImage = context.makeImage() else { return self}

        return UIImage(cgImage: contextImage, scale: self.scale, orientation: imageOrientation)
    }    
}