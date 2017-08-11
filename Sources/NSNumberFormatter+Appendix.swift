//
//  NumberFormatter.swift
//  Appendix
//
//  Created by Wesley Cope on 7/16/15.
//  Copyright © 2017 Wess Cope. All rights reserved.
//

import Foundation

public enum AppendixNumberFormatterType {
  case Currency
  case Percent
  case None
}

public extension NumberFormatter {
  public class func currencyFormatter() -> NumberFormatter {
    let formatter       = NumberFormatter()
    formatter.locale    = NSLocale.current
    
    return formatter
    
  }
  
  public class func currencyFormatter(forLocal locale: Locale) -> NumberFormatter {
    let formatter       = NumberFormatter()
    formatter.locale    = locale
    
    return formatter
  }
  
  public class func percentFormatter() -> NumberFormatter {
    let formatter = NumberFormatter.percentFormatter(forLocal: Locale.current)
    
    return formatter
  }
  
  public class func percentFormatter(forLocal locale: Locale) -> NumberFormatter {
    let formatter           = NumberFormatter()
    formatter.locale        = locale
    formatter.numberStyle   = .percent
    
    return formatter
  }
  
  public convenience init(locale:Locale?, type:AppendixNumberFormatterType = .None) {
    self.init()
    
    self.locale = locale ?? Locale.current
    
    switch type {
    case .Currency:
      numberStyle = .currency
      break
      
    case .Percent:
      numberStyle = .percent
      break
      
    default:
      numberStyle = .none
      break
    }
    
  }
}
