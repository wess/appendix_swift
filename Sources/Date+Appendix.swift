//
//  Date+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2017 Wess Cope. All rights reserved.
//

import Foundation

public enum Month : Int {
  case January    = 1
  case Febuary    = 2
  case March      = 3
  case April      = 4
  case May        = 5
  case June       = 6
  case July       = 7
  case August     = 8
  case September  = 9
  case October    = 10
  case November   = 11
  case December   = 12
  
  public static let Jan  = Month.January
  public static let Feb  = Month.Febuary
  public static let Mar  = Month.March
  public static let Apr  = Month.April
  public static let Aug  = Month.August
  public static let Sept = Month.September
  public static let Oct  = Month.October
  public static let Nov  = Month.November
  public static let Dec  = Month.December
}

public enum Interval : Int {
  case second = 1
  case minute = 60
  case hour   = 3600
  case day    = 86400
  case week   = 604800
  case year   = 31556926
}


public enum ISODateFormatter {
  case Year
  case YearMonth
  case Date
  case DateTime
  case Full
  case Extended
  
  public var format:String {
    switch self {
    case .Year:
      return "yyyy"
    case .YearMonth:
      return "yyyy-MM"
    case .Date:
      return "yyyy-MM-dd"
    case .DateTime:
      return "yyyy-MM-dd'T'HH:mmZZZZZ"
    case .Full:
      return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case .Extended:
      return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    }
  }
  
  public var formatter:DateFormatter {
    let formatter           = DateFormatter()
    formatter.dateFormat    = self.format
    
    return formatter
  }
}

public extension Int {
  public var seconds:TimeInterval {
    return TimeInterval(self) * Double(Interval.second.rawValue)
  }
  
  public var minutes:TimeInterval {
    return TimeInterval(self) * Double(Interval.minute.rawValue)
  }
  
  public var hours:TimeInterval {
    return TimeInterval(self) * Double(Interval.hour.rawValue)
  }
  
  public var days:TimeInterval {
    return TimeInterval(self) * Double(Interval.day.rawValue)
  }
  
  public var weeks:TimeInterval {
    return TimeInterval(self) * Double(Interval.week.rawValue)
  }
  
  public var years:TimeInterval {
    return TimeInterval(self) * Double(Interval.year.rawValue)
  }
}

public extension DateComponents {
  public subscript(component: Calendar.Component) -> Int? {
    switch component {
    case .era:                  return era
    case .year:                 return year
    case .month:                return month
    case .day:                  return day
    case .hour:                 return hour
    case .minute:               return minute
    case .second:               return second
    case .weekday:              return weekday
    case .weekdayOrdinal:       return weekdayOrdinal
    case .quarter:              return quarter
    case .weekOfMonth:          return weekOfMonth
    case .weekOfYear:           return weekOfYear
    case .yearForWeekOfYear:    return yearForWeekOfYear
    case .nanosecond:           return nanosecond
    default:                    return nil
    }
  }
}

public extension Date /* Properties */ {
  public static var calendar:Calendar {
    return Calendar.autoupdatingCurrent
  }
  
  public static var now:Date {
    return Date()
  }
  
  public var interval:TimeInterval {
    return timeIntervalSinceReferenceDate
  }
  
  public var month:Int {
    return value(for: .month, from: self)
  }
  
  public var day:Int {
    return value(for: .day, from: self)
  }
  
  public var year:Int {
    return value(for: .year, from: self)
  }
  
  public var hour:Int {
    return value(for: .hour, from: self)
  }
  
  public var minute:Int {
    return value(for: .minute, from: self)
  }
  
  public var second:Int {
    return value(for: .second, from: self)
  }
  
  public var nanosecond:Int {
    return value(for: .nanosecond, from: self)
  }
  
  public var weekday:Int {
    return value(for: .weekday, from: self)
  }
  
  public var weekdayOrdinal:Int {
    return value(for: .weekdayOrdinal, from: self)
  }
  
  public var weekOfMonth:Int {
    return value(for: .weekOfMonth, from: self)
  }
  
  public var weekOfYear:Int {
    return value(for: .weekOfYear, from: self)
  }
  
  public var weekForWeekOfYear:Int {
    return value(for: .yearForWeekOfYear, from: self)
  }
  
  public var quarter:Int {
    return value(for: .quarter, from: self)
  }
  
  public var era:Int {
    return value(for: .era, from: self)
  }
  
  public var calendar:Int {
    return value(for: .calendar, from: self)
  }
  
  public var timezone:Int {
    return value(for: .timeZone, from: self)
  }
  
  public var isFuture:Bool {
    return self > Date()
  }
  
  public var isPast:Bool {
    return self < Date()
  }
  
  public var isToday:Bool {
    return Date.calendar.isDateInToday(self)
  }
  
  public var isTomorrow:Bool {
    return Date.calendar.isDateInTomorrow(self)
  }
  
  public var isYesterday:Bool {
    return Date.calendar.isDateInYesterday(self)
  }
  
  public var isWeekend:Bool {
    return Date.calendar.isDateInWeekend(self)
  }
}

public extension Date /* Calculations */ {
  public func value(for component:Calendar.Component, from:Date) -> Int {
    return Date.calendar.component(component, from: from)
  }
  
  public func distance(to date:Date, component:Calendar.Component) -> Int {
    return Date.calendar.dateComponents([component], from: self, to: date)[component] ?? 0
  }
  
  public func days(to date:Date) -> Int {
    return distance(to: date, component: .day)
  }
  
  public func hours(to date:Date) -> Int {
    return distance(to: date, component: .hour)
  }
  
  public func minutes(to date:Date) -> Int {
    return distance(to: date, component: .minute)
  }
  
  public func seconds(to date:Date) -> Int {
    return distance(to: date, component: .second)
  }
  
  public func offset(to date:Date) -> (days:Int, hours:Int, minutes:Int, seconds:Int) {
    let components = Date.calendar.dateComponents([.day, .hour, .minute, .second], from: self, to: date.addingTimeInterval(0.5))
    
    return (
      days: components[.day]          ?? 0,
      hours: components[.hour]        ?? 0,
      minutes: components[.minute]    ?? 0,
      seconds: components[.second]    ?? 0
    )
  }
}

public extension Date /* Convenience */ {
  public init?(from:String, format:String)  {
    let formatter           = DateFormatter()
    formatter.dateFormat    = format
    
    guard let date = formatter.date(from: from) else {
      return nil
    }
    
    self.init(timeInterval: 0, since: date)
  }
  
  public init?(month:Int, day:Int, year:Int, calendar:NSCalendar) {
    let components      = NSDateComponents()
    components.year     = year
    components.day      = day
    components.month    = month
    
    guard let date = calendar.date(from: components as DateComponents) else {
      return nil
    }
    
    self.init(timeInterval: 0, since: date)
  }
  
  public init?(month:Int, day:Int, year:Int) {
    guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
      return nil
    }
    
    self.init(month:month, day:day, year:year, calendar:calendar)
  }
}

public extension Date /* Formatting */ {
  public func toString(format:String) -> String {
    let formatter           = DateFormatter()
    formatter.dateFormat    = format
    
    return formatter.string(from: self)
  }
  
  public func toISOString(type:ISODateFormatter) -> String {
    return type.formatter.string(from: self)
  }
}






