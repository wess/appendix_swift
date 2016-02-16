//
//  Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 8/10/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

struct Appendix {
    struct app {
        static let version:String       = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]   as! String
        static let bundleVersion:String = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]              as! String
        static let executable:String    = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]           as! String
        static let name:String          = NSBundle.mainBundle().infoDictionary!["CFBundleName"]                 as! String
    }
    
    struct system {
        static let name:String      = UIDevice.currentDevice().systemName
        static let version:String   = UIDevice.currentDevice().systemVersion
        
        static func VersionEqualTo(version:String) -> Bool {
            return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
        }
        
        static func VersionGreaterThan(version:String) -> Bool {
            return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
        }
        
        static func VersionGreaterThanOrEqual(version:String) -> Bool {
            return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
        }

        static func VersionLessThan(version:String) -> Bool {
            return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
        }
        
        static func VersionLessThanOrEqual(version:String) -> Bool {
            return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
        }

    }

    struct device {
        enum DeviceType {
            case iPad
            case iPhone
            case Unspecified
        }
        
        static let mode:String = UIDevice.currentDevice().model
        
        static func isType(type:DeviceType) -> Bool {
            switch type {
            case .iPad:
                return (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
                
            case .iPhone:
                return (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone)
                
            default:
                return false
            }
        }
    }
}

