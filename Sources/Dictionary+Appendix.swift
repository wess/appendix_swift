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
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            self = Dictionary(json: data)
        }
        
        self = [:]
    }
    
    public init(json data:NSData) {
        do {
            self = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as! [Key:Value]
        }
        catch let error as NSError {
            fatalError(error.description)
        }
        
        self = [:]
    }
 
    public func jsonData() -> NSData? {
        var cleanSelf:[String: AnyObject] = [:]
        
        for (key,val) in self {
            cleanSelf["\(key)"] = "\(val)"
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(cleanSelf, options: NSJSONWritingOptions(rawValue: 0))
            
            return data
        }
        catch {
            return nil
        }
    }
    
    public func jsonString() -> String? {
        if let data = self.jsonData() {
            if let str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
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
        
        return qry.joinWithSeparator("&")
    }
    
    public func each(handler:(key:Key, value:Value) -> ()) {
        for(key, val) in self {
            handler(key: key, value: val)
        }
    }
    
    public func filter(handler:(key:Key, value:Value) -> Bool) -> Dictionary {
        var result = Dictionary()
        
        for(key, val) in self {
            if handler(key: key, value: val) {
                result[key] = val
            }
        }

        return result
    }

    public func has(key:Key) -> Bool {
        return indexForKey(key) != nil
    }
    
    public func difference<Val:Equatable>(collection:[Key:Val]...) -> [Key:Val] {
        var result = [Key:Val]()
        
        each { k,v in
            if let item = v as? Val {
                result[k] = item
            }
        }
        
        for dict in collection {
            for(key, val) in dict {
                if result.has(key) && result[key] == val {
                    result.removeValueForKey(key)
                }
            }
        }
        
        return result
    }
}


public func - <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.difference(second)
}
