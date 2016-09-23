//
//  UITextView+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/30/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public extension UITextView {
//    public var visibleTextRange:NSRange {
//        let bounds:CGRect   = self.bounds
//        let text            = self.text ?? ""
//        let constraintSize  = CGSize(width: bounds.size.width, height: bounds.size.height)
//        let size            = text.sizeConstrainted(to: constraintSize, font: self.font!)
//        let start           = self.characterRange(at: bounds.origin)?.start
//        let end             = self.closestPosition(to: CGPoint(x: size.width, y: size.height))
//        let startingPoint   = self.offset(from: beginningOfDocument, to: start!)
//        let endingPoint     = self.offset(from: start!, to: end!)
//        
//        return NSMakeRange(startingPoint, endingPoint)
//    }

    public var visibleTextRange:Range<Int> {
        let bounds:CGRect   = self.bounds
        let text            = self.text ?? ""
        let constraintSize  = CGSize(width: bounds.size.width, height: bounds.size.height)
        let size            = text.sizeConstrainted(to: constraintSize, font: self.font!)
        let start           = self.characterRange(at: bounds.origin)?.start
        let end             = self.closestPosition(to: CGPoint(x: size.width, y: size.height))
        let startingPoint   = self.offset(from: beginningOfDocument, to: start!)
        let endingPoint     = self.offset(from: start!, to: end!)
        
        return startingPoint..<endingPoint
    }

    public func numberOfLines() -> Int {
        return Int(self.contentSize.height / self.font!.lineHeight)
    }
    
    public func rangeOfTextAtPoint(of text:String, at point:CGPoint) -> NSRange {
        let position    = self.closestPosition(to: point)
        let textRange   = self.tokenizer.rangeEnclosingPosition(position!, with: .word, inDirection: 1)!
        let start       = self.offset(from: beginningOfDocument, to: textRange.start)
        let end         = self.offset(from: beginningOfDocument, to: textRange.end)

        return NSMakeRange(start, (end - start))
    }
}
