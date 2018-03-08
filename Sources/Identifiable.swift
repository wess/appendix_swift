//
//  Identifiable.swift
//  Appendix
//
//  Created by Wess Cope on 3/8/18.
//

import Foundation

public protocol Identifiable {
  static var identifier:String  { get }
  var identifier:String         { get }
}

public extension Identifiable {
  public static var identifier:String {
    return String(describing: self)
  }
  
  public var identifier:String {
    return type(of: self).identifier
  }
}
