//
//  MainViewModelExtension.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 05.07.2022.
//

import Foundation

extension MainViewModel {
    
    func addDataPersonalLosses(data enemyPersonalLosses: [EnemyLossesPersonalToDecode]) {
        var dataToPass = [ViewData.EnemyLossesPersonal]()
        var lastDayLosses = 0
        for item in enemyPersonalLosses {
            guard let personnel = item.personnel else { return }
            guard let date = item.date else { return }
            guard let day = item.day else { return }
            guard let personnelLossesInt = item.personnel else { return }
            let POW = "\(String(describing: item.POW))"
            if let personLosses = item.personnel {
                let dayPersonLosses = "\(personLosses - lastDayLosses)"
                dataToPass.append(ViewData.EnemyLossesPersonal(date: date, day: "\(day)", personnel: "\(personnel)", dayPersonLosses: dayPersonLosses, POW: POW))
                lastDayLosses = personnelLossesInt
            }
        }
        DispatchQueue.main.async {
            self.updateViewData?(.success(dataToPass, nil, nil))
        }
    }
    
    func addDataEquipmentLosses(data enemyEquipmentLosses: [EnemyLossesEquipmentToDecode]) {
        var allDayEquipmentToPass = [ViewData.EnemyLossesEquipment]()
        for item in enemyEquipmentLosses {
            let vehiclesAndFuelTank = countVehiclesAndFuelTank(vehiclesAndFuelTank: item.vehiclesAndFuelTank, militaryAuto: item.militaryAuto, fuelTank: item.fuelTank)
            allDayEquipmentToPass.append(ViewData.EnemyLossesEquipment(date: item.date, day: "\(item.day)", aircraft: "\(item.aircraft)", helicopter: "\(item.helicopter)", tank: "\(item.tank)", APC: "\(item.APC)", fieldArtillery: "\(item.fieldArtillery)", MRL: "\(item.MRL)", militaryAuto: "\(item.militaryAuto)", fuelTank: "\(item.fuelTank)", vehiclesAndFuelTank: "\(vehiclesAndFuelTank)", drone: "\(item.drone)", navalShip: "\(item.navalShip)", antiAircraftWarfare: "\(item.antiAircraftWarfar)"))
        }
        addLastDayEquipmentLosses(data: allDayEquipmentToPass)
    }
    
    private func addLastDayEquipmentLosses(data allDayEquipmentToPass: [ViewData.EnemyLossesEquipment]) {
        var lastDayEquipmentToPass = [ViewData.CellData]()
        do {
            let lastDayEquipmentDict = try allDayEquipmentToPass[allDayEquipmentToPass.count - 1].allProperties()
            let dayBeforeLastDayEquipmentDict = try allDayEquipmentToPass[allDayEquipmentToPass.count - 2].allProperties()
            for (lastDayKeys, lastDayValues) in lastDayEquipmentDict {
                for (dayBeforeLastDayKey, dayBeforeLastDayValue) in dayBeforeLastDayEquipmentDict {
                    if lastDayKeys != "day" && lastDayKeys != "date" {
                        if let equipmentTitle = EquipmentTitle(rawValue: lastDayKeys)?.description {
                            if dayBeforeLastDayKey == lastDayKeys {
                                let countLastDay = self.anyToInt(anyData: lastDayValues) - self.anyToInt(anyData: dayBeforeLastDayValue)
                                lastDayEquipmentToPass.append(ViewData.CellData(equipmentStringForLabel: equipmentTitle, countTotal: lastDayValues as? String ?? "0", countLastDay: "+ \(countLastDay)", equipment: "\(lastDayKeys)"))
                            }
                        }
                    }
                }
            }
            lastDayEquipmentToPass.sort(by: { $0.equipmentStringForLabel < $1.equipmentStringForLabel })
            DispatchQueue.main.async {
                self.updateViewData?(.success(nil, allDayEquipmentToPass, lastDayEquipmentToPass))
            }
        } catch { print("Error", error)
            DispatchQueue.main.async {
                self.updateViewData?(.failure(error.localizedDescription))
            }
        }
    }
    
    private func countVehiclesAndFuelTank(vehiclesAndFuelTank: Int?, militaryAuto: Int?, fuelTank: Int?) -> Int {
        var totalVehiclesAndFuelTank = 0
        if vehiclesAndFuelTank == nil && militaryAuto != nil && fuelTank != nil{
            totalVehiclesAndFuelTank = (militaryAuto! + fuelTank!)
        } else {
            totalVehiclesAndFuelTank = vehiclesAndFuelTank!
        }
        return totalVehiclesAndFuelTank
    }
    
    private func anyToInt(anyData: Any) -> Int {
        guard let valueAsString = anyData as? String else { return 0 }
        guard let valueAsInt = Int(valueAsString) else { return 0 }
        return valueAsInt
    }
}
