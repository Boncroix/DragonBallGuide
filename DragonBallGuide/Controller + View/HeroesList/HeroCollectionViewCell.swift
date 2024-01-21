//
//  HeroCollectionViewCell.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 17/1/24.
//

import UIKit

final class HeroCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    static let identifier = "HeroCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    // MARK: - Configure
    func configure(with hero: DragonBallModel) {
        heroNameLabel.text = hero.name
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImage.setImage(url: imageURL)
    }
}
