//
//  SceneDelegate.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let navVC = UINavigationController()
        let coordinator = AppCoordinator()
        coordinator.navigationController = navVC
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        
        coordinator.start()
    }
}
