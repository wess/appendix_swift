//
//  UserDefaults+Appendix.swift
//  Pods
//
//  Created by Wess Cope on 8/18/17.
//
//

import Foundation

extension UserDefaults {
  public subscript(key:String) -> Any? {
    get {
      return object(forKey:key)
    }
    
    set {
      self.set(newValue, forKey: key)
      
      synchronize()
    }
  }

  public func object<T:Codable>(_ type: T.Type, with key:String, decoder:JSONDecoder = JSONDecoder()) -> T? {
    guard let data = self.value(forKey: key) as? Data else {
      return nil
    }

    return try? decoder.decode(type.self, from: data)
  }

  public func set<T:Codable>(object: T, forKey:String, encoder:JSONEncoder = JSONEncoder()) {
    guard let data = try? encoder.encode(object) else { return }

    self.set(data, forKey:forKey)
  }
}
