//
//  PropertyListable.swift
//  Appendix
//
//  Created by Wess Cope on 3/8/18.
//

import Foundation

public protocol PropertyListable {
  var properties:[String:Any]? { get }
}

public extension PropertyListable {
  public var properties:[String:Any]? {
    let mirror = Mirror(reflecting: self)
    
    guard let style = mirror.displayStyle, style == .struct || style == .class else {
      return nil
    }
    
    return mirror.children.reduce([String:Any]()) {
      var result    = $0
      result[$1.label!] = $1.value
      
      return result
    }
  }
}
