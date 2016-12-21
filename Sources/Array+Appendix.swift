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
  
  public func indexOf (condition: (Element) -> Bool) -> Int? {
    for (index, element) in self.enumerated() {
      if condition(element) {
        return index
      }
    }
    
    return nil
  }
  
  public func indexOf <U: Equatable> (item: U) -> Int? {
    if item is Element {
      return unsafeBitCast(self, to: [U].self).index(of: item)
    }
    
    return nil
  }
  
  
  public func all (test: (Element) -> Bool) -> Bool {
    for item in self {
      if !test(item) {
        return false
      }
    }
    
    return true
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
  
  public func filter(handler:(Element) -> Bool) -> Array {
    var result = [Element]()
    
    for item in self {
      if handler(item) {
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

