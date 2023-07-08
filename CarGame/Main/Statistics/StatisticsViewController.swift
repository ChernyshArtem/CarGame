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
    
    private let statistics: [(String,Int)] = [("Кики", 45000), ("Максим", 39977), ("Сэм", 38951), ("Тимон", 37898), ("Луи", 34873), ("Бэйли", 31842), ("Рокки", 29817), ("Лола", 29774), ("Грейп", 29704), ("Харли", 28682), ("Кики", 25661), ("Джесси", 23598), ("Бобо", 22569), ("Зои", 20556), ("Оливия", 19508), ("Нико", 19487), ("Лео", 17409), ("Мила", 16382), ("Кэти", 9287), ("Бенджи", 9209)]
    
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
