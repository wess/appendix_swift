//
//  Cache.swift
//  Appendix
//
//  Created by Wess Cope on 3/12/19.
//

import Foundation

public protocol CacheDelegate : class {
  func cache<Key:Hashable, Value>(_ cache:Cache<Key, Value>, willEvict value:Value)
}

open class Cache<Key:Hashable, Value> : NSObject, ExpressibleByDictionaryLiteral, NSCacheDelegate {
  private lazy var engine:NSCache<Box<Key>, Box<Value>> = {
    let cache       = NSCache<Box<Key>, Box<Value>>()
    cache.delegate  = self
    
    return cache
  }()
  
  open weak var delegate:CacheDelegate? = nil
  public private(set) var keys:Set<Key> = []

  open var name:String {
    get {
      return engine.name
    }
    
    set {
      engine.name = newValue
    }
  }
  
  open var totalCostLimit:Int {
    get {
      return engine.totalCostLimit
    }
    
    set {
      engine.totalCostLimit = newValue
    }
  }
  
  open var countLimit:Int {
    get {
      return engine.countLimit
    }
    
    set {
      engine.countLimit = newValue
    }
  }
  
  open var evictsObjectsWithDiscardedContent:Bool {
    get {
      return engine.evictsObjectsWithDiscardedContent
    }
    
    set {
      engine.evictsObjectsWithDiscardedContent = newValue
    }
  }
  
  convenience init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
    self.init()
    
    for (key, value) in sequence {
      self[key] = value
    }
  }

  required public convenience init(dictionaryLiteral elements: (Key, Value)...) {
    self.init(elements.map { (key: $0.0, value: $0.1) })
  }
  
  ///Mark - NSCacheDelegate
  public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
    guard let value = obj as? Value else { return }
    
    delegate?.cache(self, willEvict: value)
  }

}

extension Cache /* Box */ {
  private class Box<T> : NSObject {
    let value:T
    
    init(_ value:T) {
      self.value = value
    }
    
    override func isEqual(_ object: Any?) -> Bool {
      guard let otherKey  = object as? Box<Key>,
        let key       = self as? Box<Key> else { return false }
      
      return key.value == otherKey.value
    }
    
    override var hash: Int {
      guard let value = self as? Box<Value> else { return 0 }
      
      return value.hashValue
    }
  }
}

extension Cache /* Accessors */ {
  @discardableResult
  open func set(_ value:Value, for key:Key, cost:Int) -> Cache {
    self[key, cost] = value
    
    return self
  }
  
  @discardableResult
  open func set(_ value:Value, for key:Key) -> Cache {
    self[key] = value
    
    return self
  }
  
  open func get(for key:Key) -> Value? {
    return self[key]
  }
  
  open func remove(key:Key) {
    self[key] = nil
  }
  
  open func clear() {
    keys.forEach(remove)
  }
}

extension Cache /* Subscript */ {
  open subscript(key:Key, cost:Int) -> Value? {
    get {
      return engine.object(forKey: Box(key))?.value
    }
    
    set {
      guard let value = newValue else {
        keys.remove(key)
        engine.removeObject(forKey: Box(key))
        return
      }
      
      keys.insert(key)
      engine.setObject(Box(value), forKey: Box(key), cost: cost)
    }
  }
  
  open subscript(key:Key) -> Value? {
    get {
      return engine.object(forKey: Box(key))?.value
    }
    
    set {
      guard let value = newValue else {
        keys.remove(key)
        engine.removeObject(forKey: Box(key))
        return
      }
      
      keys.insert(key)
      engine.setObject(Box(value), forKey: Box(key))
    }
  }
}

extension Cache : Sequence {
  public typealias Iterator = AnyIterator<(key:Key, value:Value)>
  
  public func makeIterator() -> AnyIterator<(key: Key, value: Value)> {
    let keys      = self.keys
    var iterator  = keys.makeIterator()
    
    func next() -> (key:Key, value:Value)? {
      guard let key = iterator.next() else { return nil }
      
      if let value = self[key] {
        return (key: key, value: value)
      }
      
      self.keys.remove(key)
      
      return next()
    }
    
    return AnyIterator(next)
  }
}

extension Cache: Collection {
  public struct Index: Comparable {
    fileprivate let index: Set<Key>.Index
    
    fileprivate init(_ dictionaryIndex: Set<Key>.Index) {
      self.index = dictionaryIndex
    }
    
    public static func == (lhs: Index, rhs: Index) -> Bool {
      return lhs.index == rhs.index
    }
    
    public static func < (lhs: Index, rhs: Index) -> Bool {
      return lhs.index < rhs.index
    }
  }
  
  public var startIndex: Index {
    return Index(keys.startIndex)
  }
  
  public var endIndex: Index {
    return Index(keys.endIndex)
  }
  
  public subscript (position: Index) -> Iterator.Element {
    let key = keys[position.index]
    
    guard let value = self[key] else { fatalError("Invalid key") }
    
    return (key: key, value: value)
  }
  
  public func index(after position: Index) -> Index {
    return Index(keys.index(after: position.index))
  }
}
