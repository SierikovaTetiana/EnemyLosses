//
//  EventListCoordinator.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 06.07.2022.
//

import UIKit

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        navigationController.setViewControllers([mainViewController], animated: true)
        
    }
    
    
}
