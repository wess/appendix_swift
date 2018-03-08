//
//  Array+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import Swift

public extension Array {
  public func at(index:Int) -> Element? {
    
    func relativePosition(index:Int) -> Int {
      let location = (index % count)
      
      return location < 0 ? (count + location) : location
    }
    
    let position = relativePosition(index: index)
    
    return position < count ? self[position] : nil
  }
  
  public func difference<T: Equatable>(values: [T]...) -> [T] {
    var result = [T]()
    
    elements: for element in self {
      if let item = element as? T {
        for value in values {
          if value.contains(item) {
            continue elements
          }
        }
        
        result.append(item)
      }
    }
    
    return result
  }
}


public func - <T: Equatable> (first: Array<T>, second: T) -> Array<T> {
  return first - [second]
}

public func - <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
  return first.difference(values: second)
}

