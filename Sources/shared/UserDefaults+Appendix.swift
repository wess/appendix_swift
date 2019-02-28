//
//  UserDefaults+Appendix.swift
//  Pods
//
//  Created by Wess Cope on 8/18/17.
//
//

import Foundation

extension UserDefaults {
  /**
   Access user defaults using subscript
   
   - parameter key: Identifier that represents a value stored in UserDefaults.
  */
  public subscript(key:String) -> Any? {
    get {
      return object(forKey:key)
    }
    
    set {
      self.set(newValue, forKey: key)
      
      synchronize()
    }
  }

  /**
   Retreive a `Codable`, object stored in user defaults as an instance of the object type.
   
   - parameter type: Type of object stored.
   - parameter key: Identifier that represents a value stored in UserDefaults.
   - parameter decoder: JSON decoder to use to build the object back and return it.
   
   - returns: Object of type that is stored or nil if unavailable.
  */
  public func object<T:Codable>(_ type: T.Type, with key:String, decoder:JSONDecoder = JSONDecoder()) -> T? {
    guard let data = self.value(forKey: key) as? Data else {
      return nil
    }

    return try? decoder.decode(type.self, from: data)
  }

  /**
   Stores a `Codable` object in user defaults.
   
   - parameter object: Object to store in user defaults.
   - parameter key: Identifier that represents a value stored in UserDefaults.
   - parameter encoder: JSON encoder used to encode the object for storage.
  */
  public func set<T:Codable>(object: T, for key:String, encoder:JSONEncoder = JSONEncoder()) {
    guard let data = try? encoder.encode(object) else { return }

    self.set(data, forKey:key)
  }
}
