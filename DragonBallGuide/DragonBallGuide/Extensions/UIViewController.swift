//
//  UIViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 20/1/24.
//

import UIKit

extension UIViewController {
    func setupNavigationBarWithLogout() {
        navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        navigationItem.rightBarButtonItem = logoutButton
    }

    @objc func logoutTapped() {
        LocalDataModel.deleteToken()
        let loginViewController = LoginViewController()
        self.navigationController?.setViewControllers(
            [loginViewController], animated: true)
    }
}
