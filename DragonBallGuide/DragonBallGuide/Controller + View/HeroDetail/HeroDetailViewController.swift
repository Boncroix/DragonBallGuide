//
//  HeroDetailViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 16/1/24.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    
    
    
    
    // MARK: - Model
    private var hero: DragonBallHero
    
    // MARK: - Initializer
    init(hero: DragonBallHero) {
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

    }
    
    // MARK: - Configure
    func configure() {
        heroNameLabel.text = hero.name
        heroDescription.text = hero.description
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImageView.setImage(url: imageURL)
    }
    
    // MARK: - Actions
    @IBAction func didTapTransformations(_ sender: Any) {
    }
    
    

}
