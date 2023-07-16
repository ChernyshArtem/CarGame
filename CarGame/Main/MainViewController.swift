//
//  ViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit
import SnapKit
import AVFAudio

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
        let v = UIImageView()
        view.addSubview(v)
        v.image = UIImage(named: "toretto")
        v.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        var blur = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.frame = v.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.sendSubviewToBack(v)
        v.addSubview(blurEffectView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let path = Bundle.main.path(forResource: "main", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            SettingsManager.management.player = try AVAudioPlayer(contentsOf: url)
        } catch { }
        if SettingsManager.management.player?.isPlaying == false {
            SettingsManager.management.player?.play()
        }
        
//        if let score = SettingsManager.management.score {
//            let alert = UIAlertController(title: "Вы разбились", message: "Вы разбились со счетом: \(score)", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//            }))
//            self.present(alert, animated: true, completion: nil)
//            SettingsManager.management.score = 0
//        }
    }
    
    private func setupUI() {
        addElementsToView()
        setupProfileButton()
        setupSettingButton()
        setupStartButton()
        setupStatisticsButton()
    }
    
    private func addElementsToView() {
        view.addSubview(profileButton)
        view.addSubview(settingsButton)
        view.addSubview(startButton)
        view.addSubview(statisticsButton)
    }
    
    private func setupProfileButton() {
        profileButton.tintColor = .white
        profileButton.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        profileButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
    }
    
    private func setupSettingButton() {
        settingsButton.tintColor = .white
        settingsButton.setBackgroundImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        settingsButton.snp.makeConstraints { make in
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
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(160)
            make.height.equalTo(60)
            make.width.equalTo(180)
        }
    }
    
    private func setupStatisticsButton() {
        statisticsButton.tintColor = .white
        statisticsButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        statisticsButton.setTitle("Статистика", for: .normal)
        statisticsButton.addTarget(self, action: #selector(openStatistics), for: .touchUpInside)
        statisticsButton.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(32)
            make.left.equalTo(startButton)
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
        SettingsManager.management.player?.stop()
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc private func startGame() {
        SettingsManager.management.player?.stop()
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc private func openStatistics() {
        SettingsManager.management.player?.stop()
        navigationController?.pushViewController(StatisticsViewController(), animated: true)
    }
}

