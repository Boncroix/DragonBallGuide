//
//  HeroesListTableViewController.swift
//  DragonBallGuide
//
//  Created by Jose Bueno Cruz on 14/1/24.
//

import UIKit

final class HeroesListTableViewController: UITableViewController {
    // MARK: - Type Alias
    typealias DataSource = UITableViewDiffableDataSource<Int, DragonBallModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, DragonBallModel>
    
    // MARK: - Model
    private var transformations: [DragonBallModel] = []
    private let model = NetworkModel.shared
    private var dataSource: DataSource?
    
    // MARK: - Initializer
    init(transformations: [DragonBallModel]) {
        self.transformations = transformations
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(nibName: HeroesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroesTableViewCell.identifier
        )
        
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, transformations in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeroesTableViewCell.identifier,
                for: indexPath
            ) as? HeroesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: transformations)
            return cell
        }
        
        tableView.dataSource = dataSource
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(transformations)
        dataSource?.apply(snapshot)

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
        let hero = transformations[indexPath.row]
        DispatchQueue.main.async {
            let heroDetailViewController = HeroDetailViewController(hero: hero)
            self.navigationController?.pushViewController(heroDetailViewController,animated: true)
    
    }
}
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        180
    }
}
