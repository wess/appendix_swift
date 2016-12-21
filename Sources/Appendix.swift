//
//  Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public struct Environment {
  public struct App {
    public static let version:String       = Bundle.main.infoDictionary!["CFBundleShortVersionString"]   as! String
    public static let bundleVersion:String = Bundle.main.infoDictionary!["CFBundleVersion"]              as! String
    public static let executable:String    = Bundle.main.infoDictionary!["CFBundleExecutable"]           as! String
    public static let name:String          = Bundle.main.infoDictionary!["CFBundleName"]                 as! String
  }
  
  public struct device {
    public enum DeviceType {
      case iPad
      case iPhone
      case Unspecified
    }
    
    public static let mode:String = UIDevice.current.model
    
    public static func isType(type:DeviceType) -> Bool {
      switch type {
      case .iPad:
        return (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        
      case .iPhone:
        return (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
        
      default:
        return false
      }
    }
  }
}

public typealias Env = Environment

public func sync(target:AnyObject, block:((Void)->Void)) {
  objc_sync_enter(target)
  defer { objc_sync_exit(target) }
  
  block()
}

