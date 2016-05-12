//
//  String+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

public func formatString(string:String, pattern:String, maskCharacter character:String = "#", placeholder:String = "") -> String {
    
    let patternArray:[String]   = pattern.characters.map { String($0) }
    let stringArray:[String]    = string.characters.map { String($0) }
    var result:[String]         = patternArray
    
    var current = 0
    
    for index in 0 ..< patternArray.count {
        if current < stringArray.count {
            let char = patternArray[index]
            if char == character {
                result[index] = stringArray[current]
                
                current += 1
            }
        }
    }
    
    return result.joinWithSeparator("").stringByReplacingOccurrencesOfString(character, withString: placeholder)
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
}

public extension String /* Size */ {
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
}

public extension String /* Formatting  */ {
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

public extension String /* Date */ {
    func toDate(format:String) -> NSDate? {
        let formatter           = NSDateFormatter()
        formatter.dateFormat    = format
        
        return formatter.dateFromString(self)
    }
    
    func toISODate(type:ISODateFormatter) -> NSDate? {
        return type.formatter.dateFromString(self)
    }
}














