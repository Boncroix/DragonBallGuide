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
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.setViewControllers([loginViewController], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}


