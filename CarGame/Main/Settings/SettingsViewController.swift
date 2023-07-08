//
//  SettingsViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate {
    
    private let music: [String] = ["Классическая","Need for Speed","Гоночная","Боевая","Финальная"]
    private let difficulty: [String] = ["Легко","Средне","Сложно"]
    
    private var musicChecked: [Bool]!
    private var difficultyChecked: [Bool]!
    
    private let tableView = UITableView(frame: CGRect(), style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicChecked = Array(repeating: false, count: music.count)
        difficultyChecked = Array(repeating: false, count: difficulty.count)
        navigationItem.title = "Настройки"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return music.count
        } else {
            return difficulty.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Музыка"
        } else {
            return "Сложность"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else { return UITableViewCell() }
            cell.configurate(name: music[indexPath.row])
            if musicChecked[indexPath.row] == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else { return UITableViewCell() }
            cell.configurate(name: difficulty[indexPath.row])
            if difficultyChecked[indexPath.row] == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if musicChecked.contains(true) {
                musicChecked = Array(repeating: false, count: musicChecked.count)
            }
            tableView.deselectRow(at: indexPath, animated: false)
            musicChecked[indexPath.row] = !musicChecked[indexPath.row]
            for i in tableView.indexPathsForVisibleRows! {
                if i.section == 0 {
                    tableView.reloadRows(at: [i], with: .automatic)
                }
            }
        }
        else {
            if difficultyChecked.contains(true) {
                difficultyChecked = Array(repeating: false, count: difficultyChecked.count)
            }
            tableView.deselectRow(at: indexPath, animated: false)
            difficultyChecked[indexPath.row] = !difficultyChecked[indexPath.row]
            for i in tableView.indexPathsForVisibleRows! {
                if i.section == 1 {
                    tableView.reloadRows(at: [i], with: .automatic)
                }
            }
        }
        
    }
}