//
//  String+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2017 Wess Cope. All rights reserved.
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
  
  return result.joined(separator: "").replacingOccurrences(of: character, with: placeholder)
}


public extension String {
  public var length: Int {
    return self.characters.count
  }
  
  public func contains(_ str:String) -> Bool {
    return range(of: str) == nil ? false : true
  }
}

public extension String /* Size */ {
  public func sizeConstrainted(to width:CGFloat, font:UIFont) -> CGSize {
    let string  = NSString(string: self)
    let bounds  = string.boundingRect(with: CGSize(width: width, height: CGFloat.infinity), options: [], attributes: [NSAttributedStringKey.font: font], context: nil)
    
    return bounds.size
  }
  
  public func sizeConstrainted(to size:CGSize, font:UIFont) -> CGSize {
    let string  = NSString(string: self)
    let bounds  = string.boundingRect(with: size, options: [], attributes: [NSAttributedStringKey.font: font], context: nil)
    
    return bounds.size
  }
  
  public func trim() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

public extension String /* Formatting  */ {
  public func removeHTML() -> String {
    var html            = self
    let scanner         = Scanner(string: html)
    var text:NSString?  = ""
    
    while !scanner.isAtEnd {
      scanner.scanUpTo("<", into: nil)
      scanner.scanUpTo(">", into: &text)
      
      if let replaceText = text as String? {
        html = html.replacingOccurrences(of: "\(replaceText)>", with: "")
      }
    }
    
    return html
  }
  
  public func format(pattern:String) -> String {
    return formatString(string: self, pattern: pattern, maskCharacter: "#")
  }
  
  public func format(pattern:String, maskCharacter character:String) -> String {
    return formatString(string: self, pattern: pattern, maskCharacter: character)
  }
  
  public func format(pattern:String, maskCharacter character:String, placeholder:String) -> String {
    return formatString(string: self, pattern: pattern, maskCharacter: character, placeholder: placeholder)
  }
  
  public func contains(string:String) -> Bool {
    return range(of: string) != nil
  }
}

public extension String /* Date */ {
  func date(format:String) -> Date? {
    let formatter           = DateFormatter()
    formatter.dateFormat    = format
    
    return formatter.date(from: self)
  }
}

public extension String /* Subscript */{
  public subscript(index:Int) -> String {
    let start       = self.index(startIndex, offsetBy: index)
    let end         = self.index(start, offsetBy: 1)
    let subrange    = start ..< end
    
    return substring(with: subrange)
  }
  
  
  public subscript(range: Range<Int>) -> String {
    let start       = self.index(startIndex, offsetBy: range.lowerBound)
    let end         = self.index(start, offsetBy: range.upperBound)
    let subrange    = start ..< end
    
    return substring(with: subrange)
  }
  
  public subscript(index1: Int,  index2: Int) -> String {
    let start       = self.index(startIndex, offsetBy: index1)
    let end         = self.index(start, offsetBy:index2)
    let subrange    = start ..< end
    
    return substring(with: subrange)
  }
}












