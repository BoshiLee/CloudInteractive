//
//  DateHelper.swift
//  Bump
//
//  Created by Boshi Li on 17/05/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

prefix func -(components: DateComponents) -> DateComponents {
    var result = DateComponents()
    if components.second     != nil { result.second     = -components.second! }
    if components.minute     != nil { result.minute     = -components.minute! }
    if components.hour       != nil { result.hour       = -components.hour! }
    if components.day        != nil { result.day        = -components.day! }
    if components.weekOfYear != nil { result.weekOfYear = -components.weekOfYear! }
    if components.month      != nil { result.month      = -components.month! }
    if components.year       != nil { result.year       = -components.year! }
    return result
}

// Date + DateComponents
func +(_ lhs: Date, _ rhs: DateComponents) -> Date
{
    return Calendar.current.date(byAdding: rhs, to: lhs)!
}

// DateComponents + Dates
func +(_ lhs: DateComponents, _ rhs: Date) -> Date
{
    return rhs + lhs
}

// Date - DateComponents
func -(_ lhs: Date, _ rhs: DateComponents) -> Date
{
    return lhs + (-rhs)
}

func -(_ lhs: Date, _ rhs: Date) -> DateComponents
{
    return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                           from: rhs,
                                           to: lhs)
}

extension Int {
    
    var second: DateComponents {
        var components = DateComponents()
        components.second = self;
        return components
    }
    
    var seconds: DateComponents {
        return self.second
    }
    
    var minute: DateComponents {
        var components = DateComponents()
        components.minute = self;
        return components
    }
    
    var minutes: DateComponents {
        return self.minute
    }
    
    var hour: DateComponents {
        var components = DateComponents()
        components.hour = self;
        return components
    }
    
    var hours: DateComponents {
        return self.hour
    }
    
    var day: DateComponents {
        var components = DateComponents()
        components.day = self;
        return components
    }
    
    var days: DateComponents {
        return self.day
    }
    
    var week: DateComponents {
        var components = DateComponents()
        components.weekOfYear = self;
        return components
    }
    
    var weeks: DateComponents {
        return self.week
    }
    
    var month: DateComponents {
        var components = DateComponents()
        components.month = self;
        return components
    }
    
    var months: DateComponents {
        return self.month
    }
    
    var year: DateComponents {
        var components = DateComponents()
        components.year = self;
        return components
    }
    
    var years: DateComponents {
        return self.year
    }
    
}

extension Calendar {
    
    var year: Int {
        return Calendar.current.component(.year, from: Date())
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: Date())
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: Date())
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: Date())
    }
    
    func isDateInWeek(date: Date) -> Bool {
        return Calendar.current.isDate(Date(), equalTo: date, toGranularity: .weekOfYear)
    }
    
    func isDateInMonth(date: Date) -> Bool {
        return Calendar.current.isDate(Date(), equalTo: date, toGranularity: .month)
    }
}

fileprivate extension Date {
    
    var localTimeZoneName: String { return TimeZone.current.identifier }
    
    func toString(formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone(identifier: self.localTimeZoneName)
        return formatter.string(from: self)
    }
}

enum DateFormate: String {
    case slashDateWithHHmmss = "YYYY/MM/dd HH:mm:ss"
    case slashDateWithHHmm = "YYYY/MM/dd HH:mm"
    case dashDate = "YYYY-MM-dd"
    case dashDateWithHHmm = "YYYY-MM-dd HH:mm"
    
    private var dateFormatter:DateFormatter {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = rawValue
            return formatter
        }
    }
    //輸入string 返回Date
    func convert(_ dateString: String) -> Date? {
        guard let date = self.dateFormatter.date(from: dateString) else {
            print("cann't convert string to date, please check it!")
            return nil
        }
        return date
    }
    
    //輸入date 返回string
    func convert(_ date: Date) -> String {
        let dateString = self.dateFormatter.string(from: date)
        return dateString
    }
}

//用timeStamp來操作
struct TimeStampConverter {
    
    private let timeStamp: Double
    init(timeStamp: Double) { self.timeStamp = timeStamp }
    
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        let dateStr = Date(timeIntervalSince1970: TimeInterval(timeStamp)).toString(formate: "YYYY/MM/dd HH:mm")
        let date = formatter.date(from: dateStr)
        
        return date
    }
    
    func convertToDateString(of formate: DateFormate) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate.rawValue
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateString = formatter.string(from: date)
        return dateString
    }
}

struct DateCounter {
    //某Date離現在幾小時，返回Int
    static func countDownHours(date: Date) -> Int {
        guard let hours = (date - Date()).hour else { return 0 }
        return hours
    }
    
    //本月有幾天 返回Int
    static func getDaysFrom(month: Int) -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.year, month: month)
        let days = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: days)!
        let numDays = range.count
        return numDays
    }
}
