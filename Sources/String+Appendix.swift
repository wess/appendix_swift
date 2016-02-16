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
    
    for i in 0 ..< pattern.length {
            let str             = string as NSString
            let range:NSRange   = NSMakeRange(i, 1)
            let current         = str.substringWithRange(range)
        
        if current == character && index < string.length {
            let replacement = str.substringWithRange(NSMakeRange(index, 1))
            
            result = result.stringByReplacingCharactersInRange(range, withString: replacement)
            
            index += 1
        }
    }
    
    result = result.stringByReplacingOccurrencesOfString(character, withString: placeholder)
    
    return result as String
}

public extension String {

    
    public var length: Int {
        return self.characters.count
    }

    public subscript(index: Int) -> Character {
        let index = startIndex.advancedBy(index)
        
        return self[index]
    }
    
    public subscript(range: Range<Int>) -> String {
        let start       = startIndex.advancedBy(range.startIndex)
        let end         = startIndex.advancedBy(range.endIndex)
        let subrange    = start ..< end
        
        return self[subrange]
    }
    
    public subscript(index1: Int,  index2: Int) -> NSString {
        
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
        
        
        return self[indexFirst..<indexLast]
    }

    public func sizeConstraintedToWidth(width:CGFloat, font:UIFont) -> CGSize {
        let string  = NSString(string: self)
        let bounds  = string.boundingRectWithSize(CGSize(width: width, height: CGFloat.infinity), options: [], attributes: [NSFontAttributeName: font], context: nil)
        
        return bounds.size
    }

    public func sizeConstraintedToSize(size:CGSize, font:UIFont) -> CGSize {
        let string  = NSString(string: self)
        let bounds  = string.boundingRectWithSize(size, options: [], attributes: [NSFontAttributeName: font], context: nil)
        
        return bounds.size
    }

    public func removeHTML() -> String {
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
    
    public func format(pattern:String) -> String {
        return formatString(self, pattern: pattern, maskCharacter: "#")
    }
    
    public func format(pattern:String, maskCharacter character:String) -> String {
        return formatString(self, pattern: pattern, maskCharacter: character)
    }
    
    public func format(pattern:String, maskCharacter character:String, placeholder:String) -> String {
        return formatString(self, pattern: pattern, maskCharacter: character, placeholder: placeholder)
    }
    
    public func contains(string:String) -> Bool {
        return self.rangeOfString(string) != nil
    }
}










