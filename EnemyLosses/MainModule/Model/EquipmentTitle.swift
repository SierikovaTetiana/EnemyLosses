//
//  EquipmentTitle.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 05.07.2022.
//

import Foundation

enum EquipmentTitle: String {
    
    case aircraft = "aircraft"
    case helicopter = "helicopter"
    case tank = "tank"
    case APC = "APC"
    case fieldArtillery = "fieldArtillery"
    case MRL = "MRL"
    case vehiclesAndFuelTank = "vehiclesAndFuelTank"
    case drone = "drone"
    case navalShip = "navalShip"
    case antiAircraftWarfare = "antiAircraftWarfare"
    
    var description: String {
        switch self {
        case .aircraft:
            return "Aircraft"
        case .helicopter:
            return "Helicopter"
        case .tank:
            return "Tank"
        case .APC:
            return "APC"
        case .fieldArtillery:
            return "Field Artillery"
        case .MRL:
            return "MRL"
        case .vehiclesAndFuelTank:
            return "Vehicles and Fuel Tank"
        case .drone:
            return "Drone"
        case .navalShip:
            return "Naval Ship"
        case .antiAircraftWarfare:
            return "Anti-Aircraft Warfare"
        }
    }
}
