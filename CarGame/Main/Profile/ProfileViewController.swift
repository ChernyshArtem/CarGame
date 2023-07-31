//
//  ProfileViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 30.07.23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "User"
        setupObservers()
        setupUI()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUserName(_:)), name:    Notification.Name(rawValue: "setUserName") , object: nil)
    }
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Изменить", style: .plain, target: self, action: #selector(changeUserName))
    }
    
    @objc func changeUserName () {
        let alert = UIAlertController(title: "Изменение профиля", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OТМЕНА", comment: "Default action"), style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setUserName"), object: nil, userInfo: ["userName" : "\(alert.textFields?.first?.text ?? "User")"])
        }))
        alert.addTextField { textfield in
            textfield.placeholder = "Новое имя"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func setUserName(_ notification: Notification) {
        navigationItem.title = notification.userInfo?["userName"] as? String
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
