//
//  ViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    //MARK: UI elements
    
    private let profileButton = UIButton(type: .system)
    private let settingsButton = UIButton(type: .system)
    private let startButton = UIButton(type: .system)
    private let statisticsButton = UIButton(type: .system)
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        addElementsToView()
        setupProfileButton()
        setupSettingButton()
        setupStartButton()
        setupStatisticsButton()
    }
    
    private func addElementsToView() {
        view.backgroundColor = .systemBackground
        view.addSubview(profileButton)
        view.addSubview(settingsButton)
        view.addSubview(startButton)
        view.addSubview(statisticsButton)
    }
    
    private func setupProfileButton() {
        profileButton.backgroundColor = .systemBackground
        profileButton.tintColor = .black
        profileButton.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        profileButton.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.width.equalTo(50)
        }
    }
    
    private func setupSettingButton() {
        settingsButton.backgroundColor = .systemBackground
        settingsButton.tintColor = .black
        settingsButton.setBackgroundImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        settingsButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.width.equalTo(50)
        }
    }
    
    private func setupStartButton() {
        startButton.backgroundColor = .systemGreen
        startButton.tintColor = .white
        startButton.layer.cornerRadius = 5
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        startButton.setTitle("START!", for: .normal)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.width.equalTo(180)
        }
    }
    
    private func setupStatisticsButton() {
        statisticsButton.tintColor = .black
        statisticsButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        statisticsButton.setTitle("Статистика", for: .normal)
        statisticsButton.addTarget(self, action: #selector(openStatistics), for: .touchUpInside)
        statisticsButton.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(16)
            make.left.right.equalTo(startButton)
        }
    }
    
    //MARK: FUNC
    
    @objc private func openProfile() {
        let alert = UIAlertController(title: "Открытие профиля", message: "Тут скоро будет открытие профиля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func openSettings() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc private func startGame() {
        let alert = UIAlertController(title: "Старт гонки", message: "Тут скоро будет начало игры в гонки", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func openStatistics() {
        navigationController?.pushViewController(StatisticsViewController(), animated: true)
    }
}

