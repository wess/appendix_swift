//
//  Environment.swift
//  Appendix
//
//  Created by Wess Cope on 1/10/19.
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

