//
//  NumberFormatter.swift
//  Appendix
//
//  Created by Wesley Cope on 7/16/15.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

import Foundation

public extension NSNumberFormatter {
    class func currencyFormatter() -> NSNumberFormatter {

        return NSNumberFormatter.currencyFormatter(forLocal: NSLocale.currentLocale())
    }
    
    class func currencyFormatter(forLocal locale: NSLocale) -> NSNumberFormatter {
        return NSNumberFormatter(locale: locale, style: .CurrencyStyle)
    }
    
    class func percentFormatter() -> NSNumberFormatter {
        return NSNumberFormatter.percentFormatter(forLocal: NSLocale.currentLocale())
    }
    
    class func percentFormatter(forLocal locale: NSLocale) -> NSNumberFormatter {
        return NSNumberFormatter(locale: locale, style: .PercentStyle)
    }
    
    convenience init(locale: NSLocale, style: NSNumberFormatterStyle = .NoStyle) {
        self.init(locale: locale)

        self.numberStyle  = style
    }

    convenience init(style: NSNumberFormatterStyle = .NoStyle) {
        self.init(locale: NSLocale.currentLocale())

        self.numberStyle = style
    }
}