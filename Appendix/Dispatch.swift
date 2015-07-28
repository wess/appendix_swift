//
//  Dispatch.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

class Dispatch : NSObject {
    class func executeOnQueue(queue: String, block:()->Void, callback: ()->Void) {
        let dispatchQueue = dispatch_queue_create(queue, DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(dispatchQueue, { () -> Void in
            block()

            dispatch_async(dispatch_get_main_queue(), callback)
        })
    }
    
    class func executeInBackground(block:()->Void, callback:()->Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            block()
            
            dispatch_async(dispatch_get_main_queue(), callback)
        })
    }
    
    class func executeAfterDelay(delay:NSTimeInterval, callback:()->Void) {
        let delta:int_fast64_t  = int_fast64_t(1.0e9 * delay)
        let popTime             = dispatch_time(DISPATCH_TIME_NOW, delta)
        let queue               = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_after(popTime, queue) { () -> Void in
            callback()
        }
    }
}

