//
//  UserDefaults+Appendix.swift
//  Pods
//
//  Created by Wess Cope on 8/18/17.
//
//

import Foundation

public extension UserDefaults {
  public subscript(key:String) -> Any? {
    get {
      return object(forKey:key)
    }
    
    set {
      self.set(newValue, forKey: key)
      
      synchronize()
    }
  }
}
