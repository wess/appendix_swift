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
    public var visibleTextRange:NSRange {
        get {
            let bounds:CGRect   = self.bounds
            let text            = self.text
            let constraintSize  = CGSize(width: bounds.size.width, height: bounds.size.height)
            let size            = text.sizeConstraintedToSize(constraintSize, font: self.font!)
            let start           = self.characterRangeAtPoint(bounds.origin)?.start
            let end             = self.closestPositionToPoint(CGPoint(x: size.width, y: size.height))
            let startingPoint   = self.offsetFromPosition(self.beginningOfDocument, toPosition: start!)
            let endingPoint     = self.offsetFromPosition(start!, toPosition: end!)
            
            return NSMakeRange(startingPoint, endingPoint)
        }
    }
    
    public func numberOfLines() -> Int {
        return Int(self.contentSize.height / self.font!.lineHeight)
    }
    
    public func rangeOfTextAtPoint(point:CGPoint) -> NSRange {
        let position    = self.closestPositionToPoint(point)
        let textRange   = self.tokenizer.rangeEnclosingPosition(position!, withGranularity: .Word, inDirection: 1)!
        let start       = self.offsetFromPosition(self.beginningOfDocument, toPosition: textRange.start)
        let end         = self.offsetFromPosition(self.beginningOfDocument, toPosition: textRange.end)

        return NSMakeRange(start, (end - start))
    }
}