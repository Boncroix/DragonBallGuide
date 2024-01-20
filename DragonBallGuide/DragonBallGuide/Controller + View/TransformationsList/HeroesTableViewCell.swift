//
//  HeroesTableViewCell.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 14/1/24.
//

import UIKit

final class HeroesTableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = "HeroesTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var transformationsNameLabel: UILabel!
    @IBOutlet weak var transformationsImageView: UIImageView!
    
    
    
    
    // MARK: - Configure
    func configure(with hero: DragonBallModel) {
        transformationsNameLabel.text = hero.name
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        transformationsImageView.setImage(url: imageURL)
    }
}
