//
//  UILabel+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension UILabel {
    
    public func suggestedSize(width:Float) -> CGSize {
        return suggestedSize(string: self.text ?? "", width: width)
    }
    
    public func suggestedSize(attributedString string:NSAttributedString, width:Float) -> CGSize {
        if string.length < 1 {
            return .zero
        }
        
        return self.font.size(of: string.string, constrainedToWidth: Double(width))
    }
    
    public func suggestedSize(string:String, width:Float) -> CGSize {
        return suggestedSize(attributedString: NSAttributedString(string: string), width: width)
    }
}


