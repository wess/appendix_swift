//
//  Date+Appendix.swift
//  Appendix
//
//  Created by Wesley Cope on 6/29/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

import Foundation

public struct Months {
    static var January:Int      = 1
    static var Jan:Int          = 1
    static var Febuary:Int      = 2
    static var Feb:Int          = 2
    static var March:Int        = 3
    static var Mar:Int          = 3
    static var April:Int        = 4
    static var Apr:Int          = 4
    static var May:Int          = 5
    static var June:Int         = 6
    static var July:Int         = 7
    static var August:Int       = 8
    static var Aug:Int          = 8
    static var September:Int    = 9
    static var Sept:Int         = 9
    static var October:Int      = 10
    static var Oct:Int          = 10
    static var November:Int     = 11
    static var Nov:Int          = 11
    static var December:Int     = 12
    static var Dec:Int          = 12
}

public struct DateIntervals {
    static var Minute:Int  = 60
    static var Hour:Int    = 3600
    static var Day:Int     = 86400
    static var Week:Int    = 604800
    static var Year:Int    = 31556926
}

public struct DateComponents {
    static var Minute:NSCalendarUnit            = NSCalendarUnit.Minute
    static var Hour:NSCalendarUnit              = NSCalendarUnit.Hour
    static var Day:NSCalendarUnit               = NSCalendarUnit.Day
    static var Weekday:NSCalendarUnit           = NSCalendarUnit.Weekday
    static var WeekdayOrdinal:NSCalendarUnit    = NSCalendarUnit.WeekdayOrdinal
    static var Month:NSCalendarUnit             = NSCalendarUnit.Month
    static var Year:NSCalendarUnit              = NSCalendarUnit.Year
    static var All:NSCalendarUnit               = ([Minute, Hour, Day, Weekday, WeekdayOrdinal, Month, Year])
}

public extension NSDate {
    public var components: NSDateComponents {
        return NSCalendar.currentCalendar().components((DateComponents.All), fromDate: self)
    }
    
    public var second:Int {
        return components.second
    }
    
    public var minute:Int {
        return components.minute
    }
    
    public var hour:Int {
        return components.hour
    }
    
    public var day:Int {
        return components.day
    }
    
    public var weekOfMonth:Int {
        return components.weekOfMonth
    }
    
    public var weekOfYear:Int {
        return components.weekOfYear
    }
    
    public var month:Int {
        return components.month
    }
    
    public var year:Int {
        return components.year
    }
    
    public var firstDayOfCurrentMonth: NSDate {
        components.day = 1
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    public var lastDayOfCurrentMonth: NSDate {
        let today           = NSDate()
        let calendar        = NSCalendar.currentCalendar()
        let components      = calendar.components([DateComponents.Year, DateComponents.Month, DateComponents.Day], fromDate: today)
        let range:NSRange   = calendar.rangeOfUnit(DateComponents.Day, inUnit: DateComponents.Month, forDate: calendar.dateFromComponents(components)!)
        
        components.day = range.length
        
        return calendar.dateFromComponents(components)!
    }
    
    public class var Yesterday:NSDate {
        return NSDate.dateWithDaysBeforeNow(1)
    }
    
    public class var Tomorrow:NSDate {
        return NSDate.dateWithDaysFromNow(1)
    }
    
    public func since(date: NSDate) -> NSDate {
        return date.dateByAddingTimeInterval(date.timeIntervalSinceDate(self))
    }
    
    public func until(date: NSDate) -> NSDate {
        return date.dateByAddingTimeInterval(-(date.timeIntervalSinceDate(self)))
    }
    
    public class func dateWithDaysFromNow(days: Int) -> NSDate {
        let today       = NSDate()
        let interval    = Int(today.timeIntervalSinceReferenceDate) + DateIntervals.Day * days
        let date        = NSDate(timeIntervalSinceReferenceDate: NSTimeInterval(interval))
        
        return date
    }
    
    public class func dateWithDaysBeforeNow(days: Int) -> NSDate {
        let today       = NSDate()
        let interval    = Int(today.timeIntervalSinceReferenceDate) - DateIntervals.Day * days
        let date        = NSDate(timeIntervalSinceReferenceDate: NSTimeInterval(interval))
        
        return date
    }
    
    public func isEqualToDateIgnoringTime(date: NSDate) -> Bool
    {
        let calendar = NSCalendar.currentCalendar()
        let comp1 = calendar.components(DateComponents.All, fromDate: self)
        let comp2 = calendar.components(DateComponents.All, fromDate: date)
        
        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
    }
}

public func / (date: NSDate, right: Int) -> NSDate {
    let calendar    = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let components  = calendar.components([DateComponents.Year, DateComponents.Month, DateComponents.Day], fromDate: date)
    
    components.year = right
    
    return NSCalendar.currentCalendar().dateFromComponents(components)!
}


public func > (dateA: NSDate, dateB: NSDate) -> Bool {
    return dateA.compare(dateB) == NSComparisonResult.OrderedDescending
}

public func < (dateA: NSDate, dateB: NSDate) -> Bool {
    return dateA.compare(dateB) == NSComparisonResult.OrderedAscending
}

public func >= (dateA: NSDate, dateB: NSDate) -> Bool {
    return dateA == dateB || dateA > dateB
}

public func <= (dateA: NSDate, dateB: NSDate) -> Bool {
    return dateA == dateB || dateA < dateB
}


public func / (month: Int, right: Int) -> NSDate {
    let calendar    = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let components  = calendar.components([DateComponents.Year, DateComponents.Month, DateComponents.Day], fromDate: NSDate())
    
    components.month = month
    
    switch String(right).utf16.count {
    case 1, 2:
        components.day = right
    default:
        components.day  = 1
        components.year = right
    }
    
    return NSCalendar.currentCalendar().dateFromComponents(components)!
}
