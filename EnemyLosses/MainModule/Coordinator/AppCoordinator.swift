//
//  AppCoordinator.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 06.07.2022.
//

import UIKit

enum Event {
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func eventOccured(with type: Event, cellPressed: String, data: [ViewData.EnemyLossesEquipment])
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?

    func start() {
        let viewModel = MainViewModel()
        var vc: UIViewController & Coordinating = MainViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }

    func eventOccured(with event: Event, cellPressed: String, data: [ViewData.EnemyLossesEquipment]) {
        switch event {
        case .buttonTapped:
            let calendarModel = CalendarHelper()
//            var vc: UIViewController & Coordinating = DetailViewController(calendarModel: calendarModel)
            let vc = DetailViewController(calendarModel: calendarModel)
            vc.cellPressed = cellPressed
            vc.dataLossesEquipment = data
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
