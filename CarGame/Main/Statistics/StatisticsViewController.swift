//
//  StatisticsViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit
import SnapKit

class StatisticsViewController: UIViewController {

    private let tableView = UITableView()
    
    private let statistics: [(String,Int)] = {
        return StatisticsManager.management.listOfWinners
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Статистика побед"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StatisticsCell.self, forCellReuseIdentifier: StatisticsCell.identifier)
    }

}

extension StatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statistics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCell.identifier, for: indexPath) as? StatisticsCell else { return UITableViewCell() }
        let position = indexPath.row + 1
        
        switch position {
        case 1:
            cell.configure(position: "🥇", name: statistics[indexPath.row].0, score: statistics[indexPath.row].1)
        case 2:
            cell.configure(position: "🥈", name: statistics[indexPath.row].0, score: statistics[indexPath.row].1)
        case 3:
            cell.configure(position: "🥉", name: statistics[indexPath.row].0, score: statistics[indexPath.row].1)
        default:
            cell.configure(position: String(position)+". ", name: statistics[indexPath.row].0, score: statistics[indexPath.row].1)
        }
        
        return cell
    }
}
