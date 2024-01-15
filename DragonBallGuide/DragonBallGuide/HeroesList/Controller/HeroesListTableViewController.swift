//
//  HeroesListTableViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 14/1/24.
//

import UIKit

final class HeroesListTableViewController: UITableViewController {
    // MARK: - Type Alias
    typealias DataSource = UITableViewDiffableDataSource<Int, DragonBallHero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, DragonBallHero>
    
    // MARK: - Model
    private var heroes: [DragonBallHero] = []
    private let model = NetworkModel.shared
    private var dataSource: DataSource?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getHeroes { [weak self] result in
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
                    print("⚠️ \(error)")
            }
        }
        
        tableView.register(
            UINib(nibName: HeroesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroesTableViewCell.identifier
        )
        
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, hero in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeroesTableViewCell.identifier,
                for: indexPath
            ) as? HeroesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: hero)
            return cell
        }
        
        tableView.dataSource = dataSource

    }
}

// MARK: - TableView Delegate
extension HeroesListTableViewController {
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(at: indexPath) {
                    tableView.deselectRow(at: indexPath, animated: true)
                    UIView.animate(withDuration: 0.5, animations: {
                        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    }) { (finished) in
                        UIView.animate(withDuration: 0.5, animations: {
                            cell.transform = .identity
            })
        }
    }
}
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        200
    }
}
