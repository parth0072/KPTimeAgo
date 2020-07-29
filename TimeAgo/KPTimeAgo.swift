//
//  KPTimeAgo.swift
//  TimeAgo
//
//  Created by Parth on 20/07/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import Foundation

//Constant
fileprivate var SECOND:Double = 1
fileprivate var MINUTE:Double = (SECOND * 60)
fileprivate var HOUR:Double   = (MINUTE * 60)
fileprivate var DAY:Double    = (HOUR   * 24)
fileprivate var WEEK:Double   = (DAY    * 7)
fileprivate var MONTH:Double  = (DAY    * 31)
fileprivate var YEAR:Double   = (DAY    * 365)

public class KPTimeAgo:NSObject {
    
    ///Yesterday at 1:28 PM
    private var yesterdayDefaultFormat = "h:mm a"
    ///Friday at 1:48 AM
    private var lastWeekDefaultFormat = "EEEE 'at' h:mm a"
    ///March 30 at 1:14 PM
    private var lastMonthDefaultFormat = "MMMM d 'at' h:mm a"
    ///September 15
    private var lastYearDefaultFormat = "MMMM d"
    ///September 9, 2011
    private var otherDefaultFormat = "LLLL d, yyyy"
    
    
    private var date:Date!
    
    ///Init Method
    init(withDate:Date) {
        super.init()
        self.date = withDate
        
    }
    
    ///Init Method with cutom Format
    init(date:Date,yesterdayFormat:String?, lastWeekFormat:String?, lastMonthFormat:String?, otherFormat:String? ) {
        super.init()
        self.date = date
        self.yesterdayDefaultFormat = yesterdayFormat ?? yesterdayDefaultFormat
        self.lastWeekDefaultFormat = lastWeekFormat ?? lastWeekDefaultFormat
        self.lastMonthDefaultFormat = lastMonthFormat ?? lastMonthDefaultFormat
        self.otherDefaultFormat = otherFormat ?? otherDefaultFormat
    }
    
    public func formatDateAsTimeAgo() -> String {
        
        //Now
        let now = Date()
        let secondsSince:Double = date.timeIntervalSince(now)
        if secondsSince <= -1 {
            return "In The Future"
        }
        
        
        // < 1 minute = "Just now"
        if secondsSince < MINUTE {
            return "Just now"
        }
        
        
        // < 1 hour = "x minutes ago"
        if secondsSince < HOUR {
            return formatMinutesAgo(secondsSince)
        }
        
        
        // Today = "x hours ago"
        if isSameDay(as: now) {
            return format(asToday: secondsSince)
        }
        
        
        // Yesterday = "Yesterday at 1:28 PM"
        if isYesterday(now) {
            return formatAsYesterday()
        }
        
        
        // < Last 7 days = "Friday at 1:48 AM"
        if isLastWeek(secondsSince) {
            return formatAsLastWeek()
        }
        
        if isLastMonth(secondsSince) {
            return formatAsLastMonth()
        }
        
        // < 1 year = "September 15"
        if isLastYear(secondsSince) {
            return formatAsLastYear()
        }
        
        // Anything else = "September 9, 2011"
        return formatAsOther()
        
    }
    
    private func isSameDay(as comparisonDate: Date?) -> Bool {
        //Check by matching the date strings
        let dateComparisonFormatter = DateFormatter()
        dateComparisonFormatter.dateFormat = "yyyy-MM-dd"
        
        //Return true if they are the same
        if let comparisonDate = comparisonDate {
            return dateComparisonFormatter.string(from: self.date) == dateComparisonFormatter.string(from: comparisonDate)
        }
        return false
    }
    
    private func isYesterday(_ now: Date?) -> Bool {
        return isSameDay(as: self.date(bySubtractingDays: 1))
    }
    
    private  func date(bySubtractingDays numDays: Int) -> Date? {
        let aTimeInterval = TimeInterval(self.date.timeIntervalSinceReferenceDate + DAY * Double(-numDays))
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    private func isLastWeek(_ secondsSince: TimeInterval) -> Bool {
        return secondsSince < WEEK
    }
    
    private func isLastMonth(_ secondsSince: TimeInterval) -> Bool {
        return secondsSince < MONTH
    }
    
    private func isLastYear(_ secondsSince: TimeInterval) -> Bool {
        return secondsSince < YEAR
    }
    
    private func formatMinutesAgo(_ secondsSince: TimeInterval) -> String {
        let minutesSince = (secondsSince) / MINUTE
        
        if minutesSince == 1 {
            return "1 minute ago"
        } else {
            return "\(minutesSince) minutes ago"
        }
    }
    
    // Today = "x hours ago"
    private func format(asToday secondsSince: TimeInterval) -> String {
        //Convert to hours
        let hoursSince = (secondsSince) / HOUR
        
        //Handle Plural
        if hoursSince == 1 {
            return "1 hour ago"
        } else {
            return "\(hoursSince) hours ago"
        }
    }
    
    // Yesterday = "Yesterday at 1:28 PM"
    private func formatAsYesterday() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = yesterdayDefaultFormat
        return "Yesterday at \(dateFormatter.string(from: self.date))"
    }
    
    // < Last 7 days = "Friday at 1:48 AM"
    private func formatAsLastWeek() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = lastWeekDefaultFormat
        return dateFormatter.string(from: self.date)
    }
    
    // < Last 30 days = "March 30 at 1:14 PM"
    private func formatAsLastMonth() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = lastMonthDefaultFormat
        return dateFormatter.string(from: self.date)
    }
    
    // < 1 year = "September 15"
    private func formatAsLastYear() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = lastYearDefaultFormat
        return dateFormatter.string(from: self.date)
    }
    
    // Anything else = "September 9, 2011"
    private func formatAsOther() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = otherDefaultFormat
        return dateFormatter.string(from: self.date)
    }
    
}

extension Date {
    
    public func formatDateAsTimeAgo() -> String {
        return KPTimeAgo.init(withDate: self).formatDateAsTimeAgo()
    }
    
}
