//
//  DetailViewController.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 07.07.2022.
//

import UIKit

class DetailViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var calendarView: CalendarView!
    private var calendarModel: CalendarProtocol
    private lazy var collectionView = calendarView.collectionView
    private lazy var monthNext = calendarView.monthNext
    private lazy var monthBack = calendarView.monthBack
    var cellPressed: String = ""
    var dataLossesEquipment = [ViewData.EnemyLossesEquipment]()
    
    init(calendarModel: CalendarProtocol) {
        self.calendarModel = calendarModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        updateCalendar()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        calendarModel.setMonthView(cellPressed: cellPressed, data: dataLossesEquipment)
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func createView() {
        calendarView = CalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        monthBack.addTarget(self, action: #selector(monthBackTapped), for: .touchUpInside)
        monthNext.addTarget(self, action: #selector(monthNextTapped), for: .touchUpInside)
    }
    
    private func updateCalendar() {
        calendarModel.updateCalendarData = { [weak self] calendarData in
            self?.calendarView.calendarData = calendarData
        }
    }
    
    @objc func monthBackTapped(sender: UIButton!) {
        calendarModel.minusMonth()
        calendarModel.setMonthView(cellPressed: cellPressed, data: dataLossesEquipment)
        updateCalendar()
    }
    
    @objc func monthNextTapped(sender: UIButton!) {
        calendarModel.plusMonth()
        calendarModel.setMonthView(cellPressed: cellPressed, data: dataLossesEquipment)
        updateCalendar()
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarView.calendarDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        if !calendarView.calendarDays.isEmpty {
            cell.dateLabel.text = calendarView.calendarDays[indexPath.row]
        }
        if !calendarView.equipmentLosses.isEmpty {
            cell.lossesLabel.text = calendarView.equipmentLosses[indexPath.row]
        }
        return cell
    }
}
