//
//  MainView.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import UIKit

class MainView: UIView {
    
    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    var dataLossesEquipment = [ViewData.EnemyLossesEquipment]()
    var cellLossesEquipment = [ViewData.CellData]()
    lazy var ukraineFlag = makeUkraineFlagImageView()
    lazy var totalEnemyPersonLosses = makeTotalEnemyPersonLossesLabel()
    lazy var dayEnemyPersonLosses = makeDayEnemyPersonLossesLabel()
    lazy var enemyPersonLosses = makeEnemyPersonLossesLabel()
    lazy var collectionView = makeCollectView()
    lazy var activityIndicator = makeActivityIndicatorView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        switch viewData {
        case .initial:
            updateLosses(viewData: nil, viewDataEquipment: nil, cellData: nil, isHidden: true)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .loading:
            updateLosses(viewData: nil, viewDataEquipment: nil, cellData: nil, isHidden: false)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .success(let successPersonal, let successEquipment, let cellData):
            updateLosses(viewData: successPersonal, viewDataEquipment: successEquipment, cellData: cellData, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .failure(_):
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }
    
    private func updateLosses(viewData: [ViewData.EnemyLossesPersonal]?, viewDataEquipment: [ViewData.EnemyLossesEquipment]?, cellData: [ViewData.CellData]?, isHidden: Bool) {
        if let viewData = viewData {
            guard let personnel = viewData[(viewData.count) - 1].personnel else { return }
            guard let day = viewData[viewData.count - 1].day else { return }
            guard let dayPersonLosses = viewData[viewData.count - 1].dayPersonLosses else { return }
            totalEnemyPersonLosses.text = " ~ \(personnel)"
            dayEnemyPersonLosses.text = "+ \(dayPersonLosses)"
            enemyPersonLosses.text = "Liquidated personnel for \(day) day of the war"
        }
        if let viewDataEquipment = viewDataEquipment {
            dataLossesEquipment = viewDataEquipment
        }
        if let cellData = cellData {
            cellLossesEquipment = cellData
        }
        totalEnemyPersonLosses.isHidden = isHidden
        dayEnemyPersonLosses.isHidden = isHidden
        enemyPersonLosses.isHidden = isHidden
        collectionView.isHidden = isHidden
    }
}
