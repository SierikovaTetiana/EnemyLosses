//
//  CalendarModel.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 08.07.2022.
//

import Foundation

enum CalendarData {
    case initial
    case success(CalendarDetails)
    
    struct CalendarDetails {
        let detailImage: String
        let monthAndYear: String
        let calendarDates: [String]
        let lossesInDay: [String]
        let monthLosses: String
    }
}
