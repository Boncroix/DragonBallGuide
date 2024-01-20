//
//  HeroDetailViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 16/1/24.
//

import UIKit

final class HeroDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var heroTransformationsButton: UIButton!
    
    // MARK: - Model
    private var hero: DragonBallModel
    private var transformations: [DragonBallModel] = []
    private let model = NetworkModel.shared
    
    // MARK: - Initializer
    init(hero: DragonBallModel) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        model.getModel(path: "/api/heros/tranformations", name: "id", value: hero.id) { [weak self] result in
            switch result {
            case let .success(transformationsData):
                DispatchQueue.main.async {
                    self?.transformations = transformationsData
                    self?.checkTransformations()
                }
            case let .failure(error):
                print("⚠️ \(error)")
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func didTapTransformationsButton(_ sender: Any) {
        DispatchQueue.main.async {
            let transformationsListTableViewController = TransformationsListViewController(transformations: self.transformations)
            self.navigationController?.pushViewController(transformationsListTableViewController, animated: true)    }
    }
    
    // MARK: - Configure
    func configure() {
        setupNavigationBarWithLogout()
        heroNameLabel.text = hero.name
        heroDescription.text = hero.description
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImageView.setImage(url: imageURL)
    }
    
    func checkTransformations() {
        if transformations.isEmpty {
            heroTransformationsButton.isHidden = true
        } else {
            heroTransformationsButton.isHidden = false
        }
    }
}

