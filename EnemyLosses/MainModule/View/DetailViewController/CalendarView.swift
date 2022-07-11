//
//  CalendarView.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 07.07.2022.
//

import UIKit

class CalendarView: UIView {

    var calendarData: CalendarData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var calendarModel: CalendarProtocol = CalendarHelper()
    var calendarDays = [String]()
    var equipmentLosses = [String]()
    lazy var equipmentImage = makeEquipmentImage()
    lazy var backView = makeBackView()
    lazy var monthLabel = makeMonthLabel()
    lazy var monthBack = makeMonthBack()
    lazy var monthNext = makeMonthNext()
    lazy var collectionView = makeCollectionView()
    lazy var collectionFlowLayout = makeCollectionFlowLayout()
    lazy var monthLossesCountLabel = makeMonthLossesCountLabel()
    lazy var monthLossesLabel = makeMonthLossesLabel()
    lazy var activityIndicator = makeActivityIndicator()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        switch calendarData {
        case .initial:
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .success(let data):
            updateCalendar(image: data.detailImage, monthAndYear: data.monthAndYear, calendarDays: data.calendarDates, lossesInDay: data.lossesInDay, monthLosses:data.monthLosses, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .plusMonth:
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .minusMonth:
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func updateCalendar(image: String, monthAndYear: String, calendarDays: [String], lossesInDay: [String], monthLosses: String, isHidden: Bool) {
        monthLabel.text = String(describing: monthAndYear)
        equipmentImage.image = UIImage(named: "\(image)")
        self.calendarDays = calendarDays
        equipmentLosses = lossesInDay
        monthLossesCountLabel.text = monthLosses
        monthLossesLabel.text = "Lost in \(monthAndYear)"
        collectionView.reloadData()
    }
}