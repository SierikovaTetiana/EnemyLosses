//
//  CalendarHelper.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 08.07.2022.
//

import UIKit

protocol CalendarProtocol {
    var updateCalendarData: ((CalendarData)->())? {  get set }
    func setMonthView(cellPressed: String, data: [ViewData.EnemyLossesEquipment])
    func plusMonth()
    func minusMonth()
}

final class CalendarHelper: CalendarProtocol {
    
    public var updateCalendarData: ((CalendarData) -> ())?
    private let calendar = Calendar.current
        private var selectedDate = Date() //set to current time -> show current month (USE IF data is up to date)
//    private var selectedDate = Date(timeIntervalSince1970: 1646153822) //set to March 2022
    private var totalSquares = [String]()
    private var monthLosses = [String]()
    private var totalMonthLosses: Int = 0
    private var dictOfMonthLosses = [String : String]()
    
    init() {
        updateCalendarData?(.initial)
    }
    
    func plusMonth() {
        selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate)!
    }
    
    func minusMonth() {
        selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate)!
    }
    
    func setMonthView(cellPressed: String, data: [ViewData.EnemyLossesEquipment]) {
        clearAll()
        let daysInMonth = daysInMonth(date: selectedDate)
        let firstDayOfMonth = firstOfMonth(date: selectedDate)
        let startingSpaces = weekDay(date: firstDayOfMonth)
        let yearAndMonth = "\(yearString(date: selectedDate))-\(monthStringNumber(date: selectedDate))"
        getTotalLosses(cellPressed: cellPressed, data: data)
        getTotalMonthLosses(yearAndMonth: yearAndMonth)
        var count: Int = 1
        while(count <= 42) {
            let dataToAdd = "\(yearString(date: selectedDate))-\(monthStringNumber(date: selectedDate))-\(String(format: "%02d", (count - startingSpaces)))"
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                monthLosses.append(" ")
                totalSquares.append("")
            }
            else {
                monthLosses.append(getDayLosses(dataToAdd: dataToAdd))
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        let monthString = monthString(date: selectedDate)
        let yearString = yearString(date: selectedDate)
        updateCalendarData?(.success(CalendarData.CalendarDetails(detailImage: "\(cellPressed)", monthAndYear: "\(monthString) \(yearString)", calendarDates: totalSquares, lossesInDay: monthLosses, monthLosses: "\(totalMonthLosses)")))
    }
    
    private func getTotalLosses(cellPressed: String, data: [ViewData.EnemyLossesEquipment]) {
        var previousValue = 0
        for item in data {
            let mirror = Mirror(reflecting: item)
            for child in mirror.children  {
                if child.label == cellPressed {
                    if let lossesValue = child.value as? String {
                        if let lossesValueInt = Int(lossesValue) {
                            if let date = item.date {
                                dictOfMonthLosses[date] = "\(lossesValueInt - previousValue)"
                                previousValue = lossesValueInt
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func clearAll() {
        totalSquares.removeAll()
        monthLosses.removeAll()
        dictOfMonthLosses.removeAll()
        totalMonthLosses = 0
    }
    
    private func getTotalMonthLosses(yearAndMonth: String) {
        for (key, value) in dictOfMonthLosses {
            if key.contains(yearAndMonth) {
                totalMonthLosses += Int(value) ?? 0
            }
        }
    }
    
    private func getDayLosses(dataToAdd: String) -> String {
        if dictOfMonthLosses[dataToAdd] != "0" && dictOfMonthLosses[dataToAdd] != nil {
            return "+ \(dictOfMonthLosses[dataToAdd]!)"
        } else {
            return (" ")
        }
    }
    
    private func monthStringNumber(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date)
    }
    
    private func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    private func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    private func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    private func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    private func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
}
