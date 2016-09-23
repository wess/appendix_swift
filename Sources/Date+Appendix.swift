//
//  Date+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

//public struct Months {
//    static var January:Int      = 1
//    static var Jan:Int          = 1
//    static var Febuary:Int      = 2
//    static var Feb:Int          = 2
//    static var March:Int        = 3
//    static var Mar:Int          = 3
//    static var April:Int        = 4
//    static var Apr:Int          = 4
//    static var May:Int          = 5
//    static var June:Int         = 6
//    static var July:Int         = 7
//    static var August:Int       = 8
//    static var Aug:Int          = 8
//    static var September:Int    = 9
//    static var Sept:Int         = 9
//    static var October:Int      = 10
//    static var Oct:Int          = 10
//    static var November:Int     = 11
//    static var Nov:Int          = 11
//    static var December:Int     = 12
//    static var Dec:Int          = 12
//}
//
//public struct DateIntervals {
//    static var Minute:Int  = 60
//    static var Hour:Int    = 3600
//    static var Day:Int     = 86400
//    static var Week:Int    = 604800
//    static var Year:Int    = 31556926
//}
//
//public enum ISODateFormatter {
//    case Year
//    case YearMonth
//    case Date
//    case DateTime
//    case Full
//    case Extended
//    
//    var format:String {
//        switch self {
//        case .Year:
//            return "yyyy"
//        case .YearMonth:
//            return "yyyy-MM"
//        case .Date:
//            return "yyyy-MM-dd"
//        case .DateTime:
//            return "yyyy-MM-dd'T'HH:mmZZZZZ"
//        case .Full:
//            return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        case .Extended:
//            return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        }
//    }
//    
//    var formatter:DateFormatter {
//        let formatter           = DateFormatter()
//        formatter.dateFormat    = self.format
//        
//        return formatter
//    }
//}
//
//public extension Date /* Properties */ {
//    public var components: DateComponents {
//        let components:Set<Calendar.Component> = [Calendar.Component.year,
//                                                  Calendar.Component.month,
//                                                  Calendar.Component.day,
//                                                  Calendar.Component.weekOfYear,
//                                                  Calendar.Component.hour,
//                                                  Calendar.Component.minute,
//                                                  Calendar.Component.second,
//                                                  Calendar.Component.weekday,
//                                                  Calendar.Component.weekdayOrdinal,
//                                                  Calendar.Component.weekOfYear]
//        
//
//        return Calendar.current.dateComponents(components, from: self)
//    }
//    
//    public var second:Int? {
//        return components.second
//    }
//    
//    public var minute:Int? {
//        return components.minute
//    }
//    
//    public var hour:Int? {
//        return components.hour
//    }
//    
//    public var day:Int? {
//        return components.day
//    }
//    
//    public var weekOfMonth:Int? {
//        return components.weekOfMonth
//    }
//    
//    public var weekOfYear:Int? {
//        return components.weekOfYear
//    }
//    
//    public var month:Int? {
//        return components.month
//    }
//    
//    public var year:Int? {
//        return components.year
//    }
//    
//    public var lastDayOfCurrentMonth: NSDate {
//        let today           = NSDate()
//        let calendar        = Calendar.current
//        let components      = calendar.components([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], fromDate: today)
//        let range:NSRange   = calendar.rangeOfUnit(DateComponents.Day, inUnit: DateComponents.Month, forDate: calendar.dateFromComponents(components)!)
//        
//        components.day = range.length
//        
//        return calendar.dateFromComponents(components)!
//    }
//    
//    public class var Yesterday:NSDate {
//        return NSDate.dateWithDaysBeforeNow(1)
//    }
//    
//    public class var Tomorrow:NSDate {
//        return NSDate.dateWithDaysFromNow(1)
//    }
//}
//
//public extension NSDate /* functions */ {
//    public func since(date: NSDate) -> NSDate {
//        return date.dateByAddingTimeInterval(date.timeIntervalSinceDate(self))
//    }
//    
//    public func until(date: NSDate) -> NSDate {
//        return date.dateByAddingTimeInterval(-(date.timeIntervalSinceDate(self)))
//    }
//    
//    public class func dateWithDaysFromNow(days: Int) -> NSDate {
//        let today       = NSDate()
//        let interval    = Int(today.timeIntervalSinceReferenceDate) + DateIntervals.Day * days
//        let date        = NSDate(timeIntervalSinceReferenceDate: NSTimeInterval(interval))
//        
//        return date
//    }
//    
//    public class func dateWithDaysBeforeNow(days: Int) -> NSDate {
//        let today       = NSDate()
//        let interval    = Int(today.timeIntervalSinceReferenceDate) - DateIntervals.Day * days
//        let date        = NSDate(timeIntervalSinceReferenceDate: NSTimeInterval(interval))
//        
//        return date
//    }
//    
//    public func isEqualToDateIgnoringTime(date: NSDate) -> Bool
//    {
//        let calendar = NSCalendar.currentCalendar()
//        let comp1 = calendar.components(DateComponents.All, fromDate: self)
//        let comp2 = calendar.components(DateComponents.All, fromDate: date)
//        
//        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
//    }
//}
//
//public extension NSDate /* Formatting */ {
//    public func toString(format:String) -> String {
//        let formatter           = NSDateFormatter()
//        formatter.dateFormat    = format
//        
//        return formatter.stringFromDate(self)
//    }
//    
//    public func toISOString(type:ISODateFormatter) -> String {
//        return type.formatter.stringFromDate(self)
//    }
//}
//
//public extension NSDate /* Convenience */ {
//    public convenience init?(from string:String, format:String)  {
//        let formatter           = NSDateFormatter()
//        formatter.dateFormat    = format
//
//        guard let date = formatter.dateFromString(string) else {
//            return nil
//        }
//        
//        self.init(timeInterval: 0, sinceDate: date)
//    }
//    
//    public convenience init?(month:Int, day:Int, year:Int, calendar:NSCalendar) {
//        let components      = NSDateComponents()
//        components.year     = year
//        components.day      = day
//        components.month    = month
//        
//        guard let date = calendar.dateFromComponents(components) else {
//            return nil
//        }
//        
//        self.init(timeInterval: 0, sinceDate: date)
//    }
//    
//    public convenience init?(month:Int, day:Int, year:Int) {
//        guard let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian) else {
//            return nil
//        }
//        
//        self.init(month:month, day:day, year:year, calendar:calendar)
//    }
//}
//
//
//// Date operators
//public func / (date: NSDate, right: Int) -> NSDate {
//    let calendar    = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//    let components  = calendar.components([DateComponents.Year, DateComponents.Month, DateComponents.Day], fromDate: date)
//    
//    components.year = right
//    
//    return NSCalendar.currentCalendar().dateFromComponents(components)!
//}
//
//
//public func > (dateA: NSDate, dateB: NSDate) -> Bool {
//    return dateA.compare(dateB) == NSComparisonResult.OrderedDescending
//}
//
//public func < (dateA: NSDate, dateB: NSDate) -> Bool {
//    return dateA.compare(dateB) == NSComparisonResult.OrderedAscending
//}
//
//public func >= (dateA: NSDate, dateB: NSDate) -> Bool {
//    return dateA == dateB || dateA > dateB
//}
//
//public func <= (dateA: NSDate, dateB: NSDate) -> Bool {
//    return dateA == dateB || dateA < dateB
//}
//
//
//public func / (month: Int, right: Int) -> NSDate {
//    let calendar    = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//    let components  = calendar.components([DateComponents.Year, DateComponents.Month, DateComponents.Day], fromDate: NSDate())
//    
//    components.month = month
//    
//    switch String(right).utf16.count {
//    case 1, 2:
//        components.day = right
//    default:
//        components.day  = 1
//        components.year = right
//    }
//    
//    return NSCalendar.currentCalendar().dateFromComponents(components)!
//}
//
