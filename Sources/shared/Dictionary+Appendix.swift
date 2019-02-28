//
//  Dictionary+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 7/28/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation
import Swift

public extension Dictionary {

  public var jsonData:Data? {
    guard JSONSerialization.isValidJSONObject(self) else { return nil}

    return try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions())
  }
  
  public var jsonString:String? {
    guard let data = self.jsonData  else { return nil }

    return String(data: data, encoding: .utf8)
  }
  
  public var httpQueryString:String {
    return self.reduce([String]()) {
      return $0 + ["\($1.key)=\($1.value)"]
    }.joined(separator: "&")
  }


  public init(json string:String) {
    guard let data = string.data(using: .utf8) else {
      self = [:]
      
      return
    }
    
    self = Dictionary(json: data)
  }
  
  public init(json data:Data) {
    do {
      self = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [Key:Value]
    }
    catch let error as NSError {
      fatalError(error.description)
    }
    
    self = [:]
  }
  
  public func filter(handler:(_ key:Key, _ value:Value) -> Bool) -> Dictionary {
    var result = Dictionary()
    
    for(key, val) in self {
      if handler(key, val) {
        result[key] = val
      }
    }
    
    return result
  }
  
  public func has(key:Key) -> Bool {
    return index(forKey: key) != nil
  }
  
  

  public func difference<Val:Equatable>(collection:[Key:Val]...) -> [Key:Val] {
    var result = [Key:Val]()
    
    for (k,v) in self {
      if let item = v as? Val {
        result[k] = item
      }
    }
    
    for dict in collection {
      for(key, val) in dict {
        if result.has(key: key) && result[key] == val {
          result.removeValue(forKey: key)
        }
      }
    }
    
    return result
  }
  
  public func merge(_ dict:Dictionary) -> Dictionary {
    var this = self
    
    for (k,v) in dict {
      this.updateValue(v, forKey: k)
    }
    
    return this
  }
}

extension Dictionary /* Safe typed getters */ {
  public func string(for key:String) -> String? {
    return value(for: key)
  }
  
  public func int(for key:String) -> Int? {
    return value(for: key)
  }
  
  public func value<T>(for key:String) -> T? {
    guard let v = (self as NSDictionary).value(forKey: key), type(of: v) == T.self else { return nil }

    return v as? T
  }
}

public func - <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
  return first.difference(collection: second)
}

public func += <K, V>( lhs:inout [K:V], rhs:[K:V]) {
  for (k,v) in rhs {
    lhs.updateValue(v, forKey: k)
  }
}

func + <K,V>(lhs:[K:V], rhs:[K:V]) -> [K:V] {
  return lhs.merge(rhs)
}
