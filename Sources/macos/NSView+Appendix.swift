//
//  NSView+Appendix.swift
//  Appendix
// 
//  Created by Wess Cope (me@wess.io) on 01/24/19
//  Copyright 2018 Wess Cope
//

import Foundation
import Cocoa

extension NSView {
  var backgroundColor:NSColor? {
    get {
      guard let bgColor = layer?.backgroundColor else { return nil }
      
      return NSColor(cgColor: bgColor)
    }
    
    set {
      wantsLayer = true
      
      guard let newValue = newValue else {
        layer?.backgroundColor = nil
        
        return
      }
      
      layer?.backgroundColor = newValue.cgColor
    }
  }
  
  var borderColor:NSColor? {
    get {
      guard let border = layer?.borderColor else { return nil }
      
      return NSColor(cgColor: border)
    }
    
    set {
      wantsLayer = true
      
      guard let newValue = newValue else {
        layer?.borderColor = nil
        
        return
      }
      
      layer?.borderColor = newValue.cgColor
    }
  }
  
  var borderWidth:CGFloat? {
    get {
      return layer?.borderWidth ?? nil
    }
    
    set {
      wantsLayer = true
      
      guard let value = newValue else {
        layer?.borderWidth = 0
        
        return
      }
      
      layer?.borderWidth = value
    }
  }
  
  var cornerRadius:CGFloat? {
    get {
      return layer?.cornerRadius ?? nil
    }
    
    set {
      wantsLayer = true
      
      guard let value = newValue else {
        layer?.cornerRadius = 0
        
        return
      }
      
      layer?.cornerRadius = value
    }
  }
  
  var clipsToBounds:Bool {
    get {
      return layer?.masksToBounds ?? false
    }
    
    set {
      wantsLayer = true
      
      layer?.masksToBounds = newValue
    }
  }
  
  func add(to:NSView) -> NSView {
    to.addSubview(self)
    
    return self
  }
}
