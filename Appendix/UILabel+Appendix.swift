//
//  UILabel+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

internal extension UILabel {
    
    func suggestedSize(width:Float) -> CGSize {
        return CGSize.zero
    }
    
    func suggestedSize(attributedString string:NSAttributedString, width:Float) -> CGSize {
        if string.length < 1 {
            return .zero
        }
        
        return self.font.sizeOfString(string.string, constrainedToWidth: Double(width))
    }
    
    func suggestedSize(string:String, width:Float) -> CGSize {
        return suggestedSize(attributedString: NSAttributedString(string: string), width: width)
    }
}


