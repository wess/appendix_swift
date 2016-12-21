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
  
  public init(json string:String) {
    if let data = string.data(using: String.Encoding.utf8) {
      self = Dictionary(json: data as! NSData)
    }
    
    self = [:]
  }
  
  public init(json data:NSData) {
    do {
      self = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [Key:Value]
    }
    catch let error as NSError {
      fatalError(error.description)
    }
    
    self = [:]
  }
  
  public func jsonData() -> NSData? {
    var cleanSelf:[String: AnyObject] = [:]
    
    for (key,val) in self {
      cleanSelf["\(key)"] = "\(val)" as AnyObject?
    }
    
    do {
      let data = try JSONSerialization.data(withJSONObject: cleanSelf, options: JSONSerialization.WritingOptions(rawValue: 0))
      
      return data as NSData?
    }
    catch {
      return nil
    }
  }
  
  public func jsonString() -> String? {
    if let data = self.jsonData() {
      if let str = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as? String {
        return str
      }
    }
    
    return nil
  }
  
  public func httpQueryString() -> String {
    var qry = [String]()
    
    for (key, val) in self {
      qry.append("\(key)=\(val)")
    }
    
    return qry.joined(separator: "&")
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
}


public func - <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
  return first.difference(collection: second)
}

public func += <K, V>( lhs:inout [K:V], rhs:[K:V]) {
  for (k,v) in rhs {
    lhs.updateValue(v, forKey: k)
  }
}
