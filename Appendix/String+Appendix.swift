//
//  String+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

public func formatString(string:String, pattern:String, maskCharacter character:String = "#", placeholder:String = "") -> String {
    var result  = pattern as NSString
    var index   = 0
    
    for var i = 0; i < pattern.length; i++ {
            let str             = string as NSString
            let range:NSRange   = NSMakeRange(i, 1)
            let current         = str.substringWithRange(range)
        
        if current == character && index < string.length {
            let replacement = str.substringWithRange(NSMakeRange(index, 1))
            
            result = result.stringByReplacingCharactersInRange(range, withString: replacement)
            
            index++
        }
    }
    
    result = result.stringByReplacingOccurrencesOfString(character, withString: placeholder)
    
    return result as String
}

internal extension String {

    
    var length: Int {
        return self.characters.count
    }

    subscript(index: Int) -> Character {
        let index = advance(startIndex, index)
        
        return self[index]
    }
    
    subscript(range: Range<Int>) -> String {
        let start       = advance(startIndex, range.startIndex)
        let end         = advance(startIndex, range.endIndex)
        let subrange    = start ..< end
        
        return self[subrange]
    }
    
    subscript(index1: Int,  index2: Int) -> NSString {
        
        let strSize         = self.characters.count
        var indexFirst:Int  = index1
        var indexLast:Int   = index2
        
        if indexFirst < 0 {
            indexFirst = strSize - index1
            
            if index1 < 0 {
                indexFirst = 0
            }
        }
        
        if index2 <= 0 {
            indexLast = strSize - index2
            
            if indexLast < indexFirst {
                indexLast = indexFirst
            }
        }
        
        
        return self[Range(start:indexFirst, end: indexLast)]
    }

    func sizeConstraintedToWidth(width:CGFloat, font:UIFont) -> CGSize {
        let string  = NSString(string: self)
        let bounds  = string.boundingRectWithSize(CGSize(width: width, height: CGFloat.infinity), options: [], attributes: [NSFontAttributeName: font], context: nil)
        
        return bounds.size
    }

    func sizeConstraintedToSize(size:CGSize, font:UIFont) -> CGSize {
        let string  = NSString(string: self)
        let bounds  = string.boundingRectWithSize(size, options: [], attributes: [NSFontAttributeName: font], context: nil)
        
        return bounds.size
    }

    func removeHTML() -> String {
        var html            = self
        let scanner         = NSScanner(string: html)
        var text:NSString?  = ""
        
        while !scanner.atEnd {
            scanner.scanUpToString("<", intoString: nil)
            scanner.scanUpToString(">", intoString: &text)
            
            if let replaceText = text as? String {
                html = html.stringByReplacingOccurrencesOfString("\(replaceText)>", withString: "")
            }
        }
        
        return html
    }
    
    func format(pattern:String) -> String {
        return formatString(self, pattern: pattern, maskCharacter: "#")
    }
    
    func format(pattern:String, maskCharacter character:String) -> String {
        return formatString(self, pattern: pattern, maskCharacter: character)
    }
    
    func format(pattern:String, maskCharacter character:String, placeholder:String) -> String {
        return formatString(self, pattern: pattern, maskCharacter: character, placeholder: placeholder)
    }
}










