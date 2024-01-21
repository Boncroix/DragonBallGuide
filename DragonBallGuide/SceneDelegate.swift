//
//  SceneDelegate.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 12/1/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = UIColor.black
        
        if LocalDataModel.getToken() != nil {
            let heroesListCollectionViewController = HeroesViewController()
            navigationController.setViewControllers([heroesListCollectionViewController], animated: true)
        } else {
            let loginViewController = LoginViewController()
            navigationController.setViewControllers([loginViewController], animated: true)
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}


