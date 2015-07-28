//
//  Array+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation
import Swift

internal extension Array {
    subscript(arrayRange: Range<Int>) -> Array {
        let start = Swift.max(0, arrayRange.startIndex)
        let end = Swift.min(arrayRange.endIndex, count)
        
        if start > end {
            return []
        }
        
        return Array(self[Range(start: start, end: end)] as ArraySlice<Element>)
    }
    
    subscript(interval: HalfOpenInterval<Int>) -> Array {
        return self[Range(start: interval.start, end: interval.end)]
    }
    
    subscript(interval: ClosedInterval<Int>) -> Array {
        return self[Range(start: interval.start, end: interval.end + 1)]
    }
    
    subscript(first: Int, second: Int, other: Int...) -> Array {
        let indexes = [first, second] + other
        
        return indexes.map {
            self[$0]
        }
    }
    
    func at(index:Int) -> Element? {
        
        func relativePosition(index:Int) -> Int {
            let location = (index % count)
            
            return location < 0 ? (count + location) : location
        }
        
        let position = relativePosition(index)
        
        return position < count ? self[position] : nil
    }
    
    func indexOf (condition: Element -> Bool) -> Int? {
        for (index, element) in self.enumerate() {
            if condition(element) {
                return index
            }
        }
        
        return nil
    }
    
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return unsafeBitCast(self, [U].self).indexOf(item)
        }
        
        return nil
    }
    
    
    func all (test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }
        
        return true
    }
    
    func contains<T:Equatable>(items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }
    
    func difference<T: Equatable>(values: [T]...) -> [T] {
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
    
    func merge<U: Equatable>(values: [U]...) -> Array {
        var result = self
        
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value as! Element)
                }
            }
        }
        
        return result
    }
    
    func each(handler:(index:Int, element:Element) -> ()) {
        for (index, value) in enumerate() {
            handler(index: index, element: value)
        }
    }
    
    func filter(handler:(Element) -> Bool) -> Array {
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
    return first.difference(second)
}

