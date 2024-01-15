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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Model
    private let model = NetworkModel.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidesWhenStopped = true
        
    }
    // MARK: - Actions
    @IBAction func buttonTouchCancel(_ sender: Any) {
        zoomOut()
    }
    
    @IBAction func buttonTouchDown(_ sender: Any) {
        zoomIn()
    }
    
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        zoomOut()
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        model.login(
            user: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { [weak self] result in
            switch result {
                case .success:
                    DispatchQueue.main.async {
                        let heroesListTableViewController = HeroesListTableViewController()
                        self?.navigationController?.setViewControllers(
                            [heroesListTableViewController], animated: true)
                        self?.activityIndicator.stopAnimating()
            }
                case let .failure(error):
                    DispatchQueue.main.async {
                        print("🔴 \(error)")
                        self?.activityIndicator.stopAnimating()
                        self?.invalidCredentials()
                }
            }
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
    
    func invalidCredentials() {
        let alert = UIAlertController(
            title: "Error",
            message: "Verificación de Usuario",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
