//
//  String+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import UIKit

public func formatString(string:String, pattern:String, maskCharacter character:String = "#", placeholder:String = "") -> String {
  
  let patternArray:[String]   = pattern.map { String($0) }
  let stringArray:[String]    = string.map { String($0) }
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

public extension String /* Init */ {
  init?(base64:String) {
    let padding = String(repeating: "=", count: base64.length % 4)
    let padded  = base64 + padding
    
    guard let decoded   = Data(base64Encoded: padded, options: .ignoreUnknownCharacters),
          let deString  = String(data: decoded, encoding: .utf8) else {
        return nil
    }

    self.init(deString)
  }
}

public extension String /* Helper Vars */ {
  public var base64Encoded:String {
    return self.data(using: .utf8)!.base64EncodedString()
  }
  
  public var length: Int {
    return self.count
  }
  
  public var lines:Int {
    return self.split("\n").count
  }
  
  public var trimmed:String {
    return trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  public var urlEncoded:String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  public var urlDecoded:String {
    return removingPercentEncoding ?? self
  }
  
  public var intValue:Int? {
    guard let num = NumberFormatter().number(from: self) else { return nil }
    
    return num.intValue
  }
  
  public var floatValue:Float? {
    guard let num = NumberFormatter().number(from: self) else { return nil }
    
    return num.floatValue
  }

  public var doubleValue:Double? {
    guard let num = NumberFormatter().number(from: self) else { return nil }
    
    return num.doubleValue
  }
  
  public var empty:Bool {
    return trimmed.isEmpty
  }
  
  public var boolValue:Bool? {
    let me = trimmed.lowercased()
    if me == "true" {
      return true
    }
    
    if me == "false" {
      return false
    }
    
    return nil
  }
}

public extension String /* Manip */ {
  public func join(_ components:[Any]) -> String {
    return components.map { String(describing: $0) }.joined(separator: self)
  }
  
  public func split(_ separator:String) -> [String] {
    return components(separatedBy: separator).filter {
      !$0.trimmed.isEmpty
    }
  }
  
  public func contains(_ str:String) -> Bool {
    return range(of: str) == nil ? false : true
  }
  
  func replace(_ characters:String, with:String = "") -> String {
    let charSet     = CharacterSet(charactersIn: characters)
    let components  = self.components(separatedBy: charSet)
    
    return components.joined(separator: with)
  }
  
  func remove(_ characters:String) -> String {
    return self.replace(characters)
  }
  
  func pasteboardCopy() {
    UIPasteboard.general.strings = (UIPasteboard.general.strings ?? []) + [self]
  }
}

public extension String /* Size */ {
  public func sizeConstrainted(to width:CGFloat, font:UIFont) -> CGSize {
    let string  = NSString(string: self)
    let bounds  = string.boundingRect(with: CGSize(width: width, height: CGFloat.infinity), options: [], attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return bounds.size
  }
  
  public func sizeConstrainted(to size:CGSize, font:UIFont) -> CGSize {
    let string  = NSString(string: self)
    let bounds  = string.boundingRect(with: size, options: [], attributes: [NSAttributedString.Key.font: font], context: nil)
    
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

public extension String /* URLS */ {
  public enum StringDataType {
    case link
    case address
    case dateTime
    case phoneNumber
    case none
    
    fileprivate var type:NSTextCheckingResult.CheckingType {
      switch self {
      case .link:
        return NSTextCheckingResult.CheckingType.link
      case .address:
        return NSTextCheckingResult.CheckingType.address
      case .dateTime:
        return NSTextCheckingResult.CheckingType.date
      case .phoneNumber:
        return NSTextCheckingResult.CheckingType.phoneNumber
      default:
        return NSTextCheckingResult.CheckingType.init(rawValue: 0)
      }
    }
    
    fileprivate var raw:UInt64 {
      return type.rawValue
    }
  }

  public func detect(_ types:[StringDataType], handler:((Any?) -> ())) {
    let dataTypes:NSTextCheckingResult.CheckingType = types.reduce(NSTextCheckingResult.CheckingType.init(rawValue: 0)) { (result, current) -> NSTextCheckingResult.CheckingType in
      var _result = result
      
      _result.insert(current.type)
      
      return _result
    }
    
    guard let detector:NSDataDetector = try? NSDataDetector(types: dataTypes.rawValue) else { return }
    
    let copy = self
    detector.enumerateMatches(in: copy, options: [], range: NSMakeRange(0, self.length)) { result, flags, stop in
      guard let result = result else { return }

      handler(result.url ?? result.addressComponents ?? result.date ?? result.phoneNumber ?? nil)
    }
  }
 
  public func detect(_ type:StringDataType, handler:((Any?) -> ())) {
    detect([type], handler: handler)
  }
  
}
