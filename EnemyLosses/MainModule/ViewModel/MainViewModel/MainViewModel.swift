//
//  MainViewModel.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var updateViewData: ((ViewData)->())? {  get set }
    func startFetch(parse: ViewData.DataToFetch)
}

final class MainViewModel: MainViewModelProtocol {
    
    public var updateViewData: ((ViewData) -> ())?
    
    init() {
        updateViewData?(.initial)
    }
    
    public func startFetch(parse: ViewData.DataToFetch) {
        updateViewData?(.loading)
        if parse == ViewData.DataToFetch.personal {
            parsePersonalLosses()
        } else if parse == ViewData.DataToFetch.equipment {
            parseEquipmentLosses()
        }
    }
    
    private func parsePersonalLosses() {
        guard let urlPersonLosses = URL(string: "https://api.github.com/repos/MacPaw/2022-Ukraine-Russia-War-Dataset/contents/data/russia_losses_personnel.json")
        else { return }
        parse(url: urlPersonLosses) { parsedData, error in
            guard parsedData != nil && error == nil else { print(error as Any); return }
            do {
                let enemyPersonalLosses = try JSONDecoder().decode([EnemyLossesPersonalToDecode].self, from: parsedData!)
                self.addDataPersonalLosses(data: enemyPersonalLosses)
            } catch { print("Error", error)
                DispatchQueue.main.async {
                    self.updateViewData?(.failure(error.localizedDescription))
                }
            }
        }
    }
    
    private func parseEquipmentLosses() {
        guard let urlPersonLosses = URL(string: "https://api.github.com/repos/MacPaw/2022-Ukraine-Russia-War-Dataset/contents/data/russia_losses_equipment.json")
        else { return }
        parse(url: urlPersonLosses) { parsedData, error in
            guard parsedData != nil && error == nil else { print(error as Any); return }
            let dataToDecodeInString = String(bytes: parsedData!, encoding: String.Encoding.utf8)
            let correctedJsondataToDecode = dataToDecodeInString?.replacingOccurrences(of: "NaN", with: "0")
            let newDataToDecode = correctedJsondataToDecode?.data(using: .utf8)
            do {
                let enemyEquipmentLosses = try JSONDecoder().decode([EnemyLossesEquipmentToDecode].self, from: newDataToDecode!)
                self.addDataEquipmentLosses(data: enemyEquipmentLosses)
            } catch { print("Error", error)
                DispatchQueue.main.async {
                    self.updateViewData?(.failure(error.localizedDescription))
                }
            }
        }
    }
    
    private func parse(url: URL, completionHandler: @escaping (Data?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print("Error", error);
                DispatchQueue.main.async {
                    self.updateViewData?(.failure(error.localizedDescription))
                }; return }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(DataToDecode.self, from: data)
                    let resultContentString = String(result.content.filter { !" \n\t\r".contains($0) })
                    let dataToReturn = resultContentString.base64Decoded?.data(using: .utf8)
                    if dataToReturn == nil {
                        DispatchQueue.main.async {
                            self.updateViewData?(.failure("Parsed data is empty"))
                        }
                    }
                    completionHandler(dataToReturn, nil)
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
