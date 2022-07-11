//
//  ViewData.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import UIKit

enum ViewData {
    case initial
    case loading
    case success([EnemyLossesPersonal]?, [EnemyLossesEquipment]?, [CellData]?)
    case failure(String)
    
    struct EnemyLossesPersonal {
        let date: String?
        let day: String?
        let personnel: String?
        let dayPersonLosses: String?
        let POW: String?
    }
    
    struct EnemyLossesEquipment: Loopable {
        let date: String?
        let day: String?
        let aircraft: String?
        let helicopter: String?
        let tank: String?
        let APC: String?
        let fieldArtillery: String?
        let MRL: String?
        let militaryAuto: String?
        let fuelTank: String?
        let vehiclesAndFuelTank: String?
        let drone: String?
        let navalShip: String?
        let antiAircraftWarfare: String?
    }
    
    struct CellData {
        let equipmentStringForLabel: String
        let countTotal: String
        let countLastDay: String
        let equipment: String
    }
    
    enum DataToFetch {
        case personal
        case equipment
    }
}
