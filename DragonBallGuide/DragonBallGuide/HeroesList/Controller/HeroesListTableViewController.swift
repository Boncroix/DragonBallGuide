//
//  HeroesListTableViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 14/1/24.
//

import UIKit

class HeroesListTableViewController: UITableViewController {
    
    // MARK: - Model
    private let model = NetworkModel.shared
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getHeroes { result in
            switch result {
            case let .success(heroes):
                print("🟢 \(heroes)")
            case let .failure(error):
                print("⚠️ \(error)")
            }
        }

    }
}
