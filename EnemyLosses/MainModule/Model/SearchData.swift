//
//  SearchData.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 03.07.2022.
//

import Foundation

struct DataToDecode: Codable {
    let content: String
}

struct EnemyLossesPersonalToDecode: Codable {
    let date: String?
    let day: Int?
    let personnel: Int?
    let POW: Int?
}

struct EnemyLossesEquipmentToDecode: Codable {
    let date: String
    let day: StringOrInt
    let aircraft: Int
    let helicopter: Int
    let tank: Int
    let APC: Int
    let fieldArtillery: Int
    let MRL: Int
    let militaryAuto: Int
    let fuelTank: Int
    let vehiclesAndFuelTank: Int?
    let drone: Int
    let navalShip: Int
    let antiAircraftWarfar: Int
    
    private enum CodingKeys : String, CodingKey {
        case fieldArtillery = "field artillery"
        case date
        case day
        case aircraft
        case helicopter
        case tank
        case APC
        case MRL
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case vehiclesAndFuelTank = "vehicles and fuel tanks"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfar = "anti-aircraft warfare"
    }
}

enum StringOrInt: Codable {
    case string(String)
    case int(Int)
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }
    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}
