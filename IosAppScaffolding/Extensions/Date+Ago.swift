//
//  Date+Ago.swift
//  iChecks
//
//  Created by Christophe Guégan on 11/09/2024.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}


let ANY_VALID_DATE: String = #"(\b(0?[1-9]|[12]\d|30|31)[^\w\d\r\n:](0?[1-9]|1[0-2])[^\w\d\r\n:](\d{4}|\d{2})\b)|(\b(0?[1-9]|1[0-2])[^\w\d\r\n:](0?[1-9]|[12]\d|30|31)[^\w\d\r\n:](\d{4}|\d{2})\b)"#
let DATE_FORMATTER = DateFormatter()

extension Date {
    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }

    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }

    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }

    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }

    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }

    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    var isInTheFuture: Bool {
        return Date() < self
    }

    var isInThePast: Bool {
        return self < Date()
    }

    var localTimeStamp: String {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        f.timeZone = TimeZone.current
        return f.string(from: self)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    static func intervalString(date1: Date, date2: Date, pattern: String = "jm") -> String {
        let df = DateIntervalFormatter()
        df.dateTemplate = pattern
        df.dateStyle = .none
//        pp("\(date1) / \(date2)")
        let interval: TimeInterval = date2 - date1
        let stringDate = df.string(from: date1, to: date1.addingTimeInterval(interval))
        // just keep time
        let removedDates = stringDate.replacingOccurrences(of: ANY_VALID_DATE,
                                                           with: "",
                                                           options: .regularExpression,
                                                           range: stringDate.startIndex ..< stringDate.endIndex)
        let removeCommas = removedDates.replacingOccurrences(of: ", ", with: "")
        return removeCommas
    }

    static func timeToDate(hour: Int, minute: Int, timeZone: String = "MSK") -> Date {
        let now = Date()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: now)
        dateComponents.timeZone = TimeZone(abbreviation: timeZone)
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0
        return Calendar.current.date(from: dateComponents) ?? Date()
    }

    func string(format: String) -> String {
        DATE_FORMATTER.dateFormat = format
        return DATE_FORMATTER.string(from: self)
    }

    func dMMMMyyyy() -> String {
        string(format: "d MMMM yyyy")
    }
    
}
