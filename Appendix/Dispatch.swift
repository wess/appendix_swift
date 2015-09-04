//
//  Dispatch.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

public class Dispatch : NSObject {
    /**
        Executes block on the background for provided queue.
    
        :param: Name of queue
        :param: Block called on background queue.
        :param: Block called on main thread once background block is complete.
    */
    public class func executeOnQueue(queue: String, block:()->Void, callback: ()->Void) {
        let dispatchQueue = dispatch_queue_create(queue, DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(dispatchQueue, { () -> Void in
            block()

            dispatch_async(dispatch_get_main_queue(), callback)
        })
    }
    
    /**
        Executes block on the background for provided queue.
    
        :param: Name of queue
        :param: Block called on background queue.
    */
    public class func executeInBackground(block:()->Void, callback:()->Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            block()
            
            dispatch_async(dispatch_get_main_queue(), callback)
        })
    }
    
    /**
        Executes block on the background for provided queue.
    
        :param: Period to wait before calling block.
        :param: Block called after period.
    */
    public class func executeAfterDelay(delay:NSTimeInterval, callback:()->Void) {
        let delta:int_fast64_t  = int_fast64_t(1.0e9 * delay)
        let popTime             = dispatch_time(DISPATCH_TIME_NOW, delta)
        let queue               = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_after(popTime, queue) { () -> Void in
            callback()
        }
    }
}

