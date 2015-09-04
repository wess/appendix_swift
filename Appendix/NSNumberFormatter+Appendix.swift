//
//  NumberFormatter.swift
//  Appendix
//
//  Created by Wesley Cope on 7/16/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension NSNumberFormatter {
    public class func currencyFormatter() -> NSNumberFormatter {
        return NSNumberFormatter.currencyFormatter(forLocal: NSLocale.currentLocale())
    }
    
    public class func currencyFormatter(forLocal locale: NSLocale) -> NSNumberFormatter {
        return NSNumberFormatter(locale: locale, style: .CurrencyStyle)
    }
    
    public class func percentFormatter() -> NSNumberFormatter {
        return NSNumberFormatter.percentFormatter(forLocal: NSLocale.currentLocale())
    }
    
    public class func percentFormatter(forLocal locale: NSLocale) -> NSNumberFormatter {
        return NSNumberFormatter(locale: locale, style: .PercentStyle)
    }
    
    public convenience init(locale: NSLocale, style: NSNumberFormatterStyle = .NoStyle) {
        self.init(locale: locale)

        self.numberStyle  = style
    }

    public convenience init(style: NSNumberFormatterStyle = .NoStyle) {
        self.init(locale: NSLocale.currentLocale())

        self.numberStyle = style
    }
}