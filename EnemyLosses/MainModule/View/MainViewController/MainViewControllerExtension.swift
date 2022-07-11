//
//  MainViewControllerExtension.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 07.07.2022.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.cellLossesEquipment.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        if !mainView.dataLossesEquipment.isEmpty {
            cell.count.text = mainView.cellLossesEquipment[indexPath.row].countTotal
            cell.lastDayCount.text = mainView.cellLossesEquipment[indexPath.row].countLastDay
            cell.title.text = mainView.cellLossesEquipment[indexPath.row].equipmentStringForLabel
            cell.image.image = UIImage(named: mainView.cellLossesEquipment[indexPath.row].equipment)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.eventOccured(with: .buttonTapped, cellPressed: mainView.cellLossesEquipment[indexPath.row].equipment, data: mainView.dataLossesEquipment)
    }
}
