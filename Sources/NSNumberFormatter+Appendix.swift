//
//  NumberFormatter.swift
//  Appendix
//
//  Created by Wesley Cope on 7/16/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public enum AppendixNumberFormatterType {
    case Currency
    case Percent
    case None
}

public extension NSNumberFormatter {
    public class func currencyFormatter() -> NSNumberFormatter {
        let formatter       = NSNumberFormatter()
        formatter.locale    = NSLocale.currentLocale()

        return formatter

    }
    
    public class func currencyFormatter(forLocal locale: NSLocale) -> NSNumberFormatter {
        let formatter       = NSNumberFormatter()
        formatter.locale    = locale
        
        return formatter
    }
    
    public class func percentFormatter() -> NSNumberFormatter {
        let formatter = NSNumberFormatter.percentFormatter(forLocal: NSLocale.currentLocale())

        return formatter
    }
    
    public class func percentFormatter(forLocal locale: NSLocale) -> NSNumberFormatter {
        let formatter           = NSNumberFormatter()
        formatter.locale        = locale
        formatter.numberStyle   = .PercentStyle
        
        return formatter
    }

    public convenience init(locale:NSLocale?, type:AppendixNumberFormatterType = .None) {
        self.init()

        self.locale = locale ?? NSLocale.currentLocale()
        
        switch type {
        case .Currency:
            numberStyle = .CurrencyStyle
            break
            
        case .Percent:
            numberStyle = .PercentStyle
            break
            
        default:
            numberStyle = .NoStyle
            break
        }
        
    }
}