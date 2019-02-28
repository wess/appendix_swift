//
//  NSColor+Appendix.swift
//  Appendix
// 
//  Created by Wess Cope (me@wess.io) on 01/24/19
//  Copyright 2018 Wess Cope
//

import Cocoa

extension NSColor {
  public convenience init(hexString: String, alpha:CGFloat = 1) {
    var hex = hexString.replacingOccurrences(of: "#", with: "")
    
    if hex.count == 3 {
      var result = ""
      
      hex.forEach { result.append(String(repeating: String($0), count: 2)) }
      
      hex = result
    }
    
    guard let hexValue = Int(hex, radix:16) else { fatalError("Invalid Color hex code") }
    
    let red   = CGFloat((hexValue >> 16) & 0xff)
    let green = CGFloat((hexValue >> 8) & 0xff)
    let blue  = CGFloat(hexValue & 0xff)
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  public convenience init(hexString: String) {
    self.init(hexString: hexString, alpha:1)
  }
}
