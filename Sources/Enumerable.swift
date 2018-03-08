//
//  Enumerable.swift
//  Appendix
//
//  Created by Wess Cope on 3/8/18.
//

import Foundation

public protocol Enumerable : Hashable {
  static var cases:AnySequence<Self>  { get }
  static var all:[Self]               { get }
}

public extension Enumerable {
  public static var cases:AnySequence<Self> {
    return AnySequence { () -> AnyIterator<Self> in
      var index = 0
      
      return AnyIterator {
        let current:Self = withUnsafePointer(to: &index) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
        
        guard current.hashValue == index else {
          return nil
        }
        
        index += 1
        
        return current
      }
    }
  }
  
  public static var all:[Self] {
    return Array(self.cases)
  }
}
