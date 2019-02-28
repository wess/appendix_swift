
//
//  Dispatch+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public struct Dispatch {
  private static var onceTokens:[String] = []
  
  public static func once(_ token:String, callback:() -> ()) {
    objc_sync_enter(self)
    defer { objc_sync_exit(self) }

    guard onceTokens.contains(token) else {
      return
    }
    
    onceTokens.append(token)
    callback()
  }
  
  public static func after(_ interval:TimeInterval, callback: @escaping (() -> Void)) {
    let time = DispatchTime.now() + Double(Int64(interval * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: callback)
  }
  
  public static func sync(callback:() -> ()) {
    objc_sync_enter(self)
    defer { objc_sync_exit(self) }
    
    callback()
  }
}
