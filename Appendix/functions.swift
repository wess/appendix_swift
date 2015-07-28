//
//  functions.swift
//  Appendix
//
//  Created by Wesley Cope on 6/30/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}
