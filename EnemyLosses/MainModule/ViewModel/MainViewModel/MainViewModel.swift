//
//  MainViewModel.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var updateViewData: ((ViewData)->())? {  get set }
    func startFetch()
}

final class MainViewModel: MainViewModelProtocol {
    
    public var updateViewData: ((ViewData) -> ())?
    var personalDataToPass = [ViewData.EnemyLossesPersonal]()
    
    init() {
        updateViewData?(.initial)
    }
    
    public func startFetch() {
        updateViewData?(.loading)
        var personalLossesDataToPass = [ViewData.EnemyLossesPersonal]()
        var equipmentLossesDataToPass = [ViewData.EnemyLossesEquipment]()
        var lastDayequipmentLossesDataToPass = [ViewData.CellData]()
        parsePersonalLosses { enemyPersonalLosses in
            self.addDataPersonalLosses(data: enemyPersonalLosses) { dataToPass in
                personalLossesDataToPass = dataToPass
                DispatchQueue.main.async {
                    self.updateViewData?(.success(personalLossesDataToPass, equipmentLossesDataToPass, lastDayequipmentLossesDataToPass))
                }
            }
        }
        parseEquipmentLosses { enemyEquipmentLosses in
            self.addDataEquipmentLosses(data: enemyEquipmentLosses) { allDayEquipmentToPass in
                self.addLastDayEquipmentLosses(data: allDayEquipmentToPass) { lastDayEquipmentToPass in
                    equipmentLossesDataToPass = allDayEquipmentToPass
                    lastDayequipmentLossesDataToPass = lastDayEquipmentToPass
                    DispatchQueue.main.async {
                        self.updateViewData?(.success(personalLossesDataToPass, equipmentLossesDataToPass, lastDayequipmentLossesDataToPass))
                    }
                }
            }
        }
    }
    
    private func parsePersonalLosses(completion: @escaping ([EnemyLossesPersonalToDecode]) -> Void) {
        guard let urlPersonLosses = URL(string: "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json")
        else { return }
        let task = URLSession.shared.dataTask(with: urlPersonLosses) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.updateViewData?(.failure(error.localizedDescription))
                }; return }
            if let data = data {
                do {
                    let enemyPersonalLosses = try JSONDecoder().decode([EnemyLossesPersonalToDecode].self, from: data)
                    completion(enemyPersonalLosses)
                } catch {
                    DispatchQueue.main.async {
                        self.updateViewData?(.failure(error.localizedDescription))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.updateViewData?(.failure("Data is empty"))
                }
            }
        }
        task.resume()
    }
    
    private func parseEquipmentLosses(completion: @escaping ([EnemyLossesEquipmentToDecode])  -> Void) {
        guard let urlEquipmentLosses = URL(string: "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json")
        else { return }
        let task = URLSession.shared.dataTask(with: urlEquipmentLosses) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.updateViewData?(.failure(error.localizedDescription))
                }; return }
            if let data = data {
                let dataToDecodeInString = String(bytes: data, encoding: String.Encoding.utf8)
                let correctedJsondataToDecode = dataToDecodeInString?.replacingOccurrences(of: "NaN", with: "0")
                let newDataToDecode = correctedJsondataToDecode?.data(using: .utf8)
                do {
                    if let newDataToDecode = newDataToDecode{
                        let enemyEquipmentLosses = try JSONDecoder().decode([EnemyLossesEquipmentToDecode].self, from: newDataToDecode)
                        completion(enemyEquipmentLosses)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.updateViewData?(.failure(error.localizedDescription))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.updateViewData?(.failure("Data is empty"))
                }
            }
        }
        task.resume()
    }
}
