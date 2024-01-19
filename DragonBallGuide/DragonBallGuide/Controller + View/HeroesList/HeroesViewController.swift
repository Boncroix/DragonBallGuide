//
//  HeroesViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 17/1/24.
//

import UIKit

final class HeroesViewController: UIViewController, UICollectionViewDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, DragonBallModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, DragonBallModel>
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Model
    private var heroes: [DragonBallModel] = []
    private let model: NetworkModel = .shared
    private var dataSource: DataSource?
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let numberOfColumns: CGFloat = (screenWidth > 600) ? 3 : 2
        let spacing: CGFloat = 8
        let totalSpacing = (numberOfColumns - 1) * spacing
        let itemWidth = (screenWidth - totalSpacing) / numberOfColumns
        
        layout.itemSize = CGSize(width: itemWidth, height: 150)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.redCustom
        
        let registration = UICollectionView.CellRegistration<
            HeroCollectionViewCell,
            DragonBallModel
        >(
            cellNib: UINib(
                nibName: HeroCollectionViewCell.identifier,
                bundle: nil
            )
        ) { cell, _, hero in
            cell.configure(with: hero)
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, hero in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: hero
            )
        }
        
        collectionView.dataSource = dataSource

        model.getModel(path: "/api/heros/all", name: "name", value: "") { [weak self] result in
            switch result {
                case let .success(heroesData):
                    DispatchQueue.main.async {
                        self?.heroes = heroesData
                        var snapshot = Snapshot()
                        snapshot.appendSections([0])
                        snapshot.appendItems(heroesData)
                        self?.dataSource?.apply(snapshot)
                }
                case let .failure(error):
                    print(error)
            }
        }
    }
}

// MARK: - CollectionView Delegate
extension HeroesViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            
            let hero = heroes[indexPath.row]
            DispatchQueue.main.async {
                let heroDetailViewController = HeroDetailViewController(hero: hero)
                self.navigationController?.pushViewController(heroDetailViewController,animated: true)
        }
    }
}
