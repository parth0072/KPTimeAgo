//
//  KPTimeAgo.swift
//  TimeAgo
//
//  Created by Parth on 20/07/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import Foundation


fileprivate var SECOND:Double = 1
fileprivate var MINUTE:Double = (SECOND * 60)
fileprivate var HOUR:Double   = (MINUTE * 60)
fileprivate var DAY:Double    = (HOUR   * 24)
fileprivate var WEEK:Double   = (DAY    * 7)
fileprivate var MONTH:Double  = (DAY    * 31)
fileprivate var YEAR:Double   = (DAY    * 365)


extension Date {
    
    public func formatDateAsTimeAgo() -> String {
        //Now
        let now = Date()
        let secondsSince:Double = self.timeIntervalSince(now)
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
    
    fileprivate func isSameDay(as comparisonDate: Date?) -> Bool {
        //Check by matching the date strings
        let dateComparisonFormatter = DateFormatter()
        dateComparisonFormatter.dateFormat = "yyyy-MM-dd"
        
        //Return true if they are the same
        if let comparisonDate = comparisonDate {
            return dateComparisonFormatter.string(from: self) == dateComparisonFormatter.string(from: comparisonDate)
        }
        return false
    }
    
    fileprivate func isYesterday(_ now: Date?) -> Bool {
        return isSameDay(as: now?.date(bySubtractingDays: 1))
    }
    
    fileprivate  func date(bySubtractingDays numDays: Int) -> Date? {
        let aTimeInterval = TimeInterval(timeIntervalSinceReferenceDate + DAY * Double(-numDays))
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    fileprivate func isLastWeek(_ secondsSince: TimeInterval) -> Bool {
        return secondsSince < WEEK
    }
    
    fileprivate func isLastMonth(_ secondsSince: TimeInterval) -> Bool {
        return secondsSince < MONTH
    }
    
    fileprivate func isLastYear(_ secondsSince: TimeInterval) -> Bool {
        return secondsSince < YEAR
    }
    
    fileprivate func formatMinutesAgo(_ secondsSince: TimeInterval) -> String {
        let minutesSince = (secondsSince) / MINUTE
        
        if minutesSince == 1 {
            return "1 minute ago"
        } else {
            return "\(minutesSince) minutes ago"
        }
    }
    
    // Today = "x hours ago"
    fileprivate func format(asToday secondsSince: TimeInterval) -> String {
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
    fileprivate func formatAsYesterday() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = "h:mm a"
        return "Yesterday at \(dateFormatter.string(from: self))"
    }
    
    // < Last 7 days = "Friday at 1:48 AM"
    fileprivate func formatAsLastWeek() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = "EEEE 'at' h:mm a"
        return dateFormatter.string(from: self)
    }
    
    // < Last 30 days = "March 30 at 1:14 PM"
    fileprivate func formatAsLastMonth() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = "MMMM d 'at' h:mm a"
        return dateFormatter.string(from: self)
    }
    
    // < 1 year = "September 15"
    fileprivate func formatAsLastYear() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: self)
    }
    
    // Anything else = "September 9, 2011"
    fileprivate func formatAsOther() -> String {
        //Create date formatter
        let dateFormatter = DateFormatter()
        
        //Format
        dateFormatter.dateFormat = "LLLL d, yyyy"
        return dateFormatter.string(from: self)
    }
    
    
}

