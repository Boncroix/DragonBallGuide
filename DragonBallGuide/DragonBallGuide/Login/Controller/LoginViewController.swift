//
//  LoginViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 12/1/24.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidesWhenStopped = true
        
    }
    // MARK: - Actions
    @IBAction func buttonTouchCancel(_ sender: Any) {
        zoomOut()
    }
    
    @IBAction func burronToucheCancel(_ sender: Any) {
        zoomIn()
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        zoomOut()
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
}

// MARK: - Animations
extension LoginViewController {
    func zoomIn() {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.5
        ) { [weak self] in
            self?.loginButton.transform = .identity
                .scaledBy(x: 0.94, y: 0.94)
        }
    }
    
    func zoomOut() {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 2
        ) { [weak self] in
            self?.loginButton.transform = .identity
        }
    }
}
