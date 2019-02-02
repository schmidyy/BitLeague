//
//  Date+Extensions.swift
//  Plan
//
//  Created by Ozzie Kirkby on 2018-09-08.
//  Copyright © 2018 kirkbyo. All rights reserved.
//

import Foundation

extension Date {
    func startOfMonth() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }
    
    func endOfMonth() -> Date? {
        guard let month = self.startOfMonth() else { return nil }
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: month)
    }
    
    func isSameDay(as date: Date) -> Bool {
        let lhs = Calendar.current.dateComponents([.month, .day, .year], from: self)
        let rhs = Calendar.current.dateComponents([.month, .day, .year], from: date)
        
        return lhs.day == rhs.day && lhs.month == rhs.month && lhs.year == rhs.year
    }
    
    func isSameWeek(as date: Date) -> Bool {
        let lhs = Calendar.current.dateComponents([.weekOfYear], from: self)
        let rhs = Calendar.current.dateComponents([.weekOfYear], from: date)
        
        return lhs.weekOfYear == rhs.weekOfYear
    }
    
    var dayOfWeek: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: self).capitalized(with: Locale.current)
    }
    
    var dayOfWeekShort: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        
        return formatter.string(from: self).capitalized(with: Locale.current)
    }
    
    var weekOfYear: Int? {
        return Calendar.current.dateComponents([.weekOfYear], from: self).weekOfYear
    }
    
    var month: Int? {
        guard let m = Calendar.current.dateComponents([.month], from: self).month else { return nil }
        return m - 1
    }
    
    static var standardDate: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date()) ?? Date ()
    }
    
    func mediumFormat(withTime: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if withTime {
            dateFormatter.timeStyle = .medium
        }
        return dateFormatter.string(from: self)
    }
    
    func shortFormat(withTime: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self)
    }
}
