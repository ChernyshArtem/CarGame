//
//  ProfileViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 30.07.23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
        
    private let keyUserName = "userName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fillUserName()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Изменить", style: .plain, target: self, action: #selector(changeUserName))
    }
    
    @objc func changeUserName () {
        let alert = UIAlertController(title: "Изменение профиля", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OТМЕНА", comment: "Default action"), style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            let newUserName = alert.textFields?.first?.text ?? "User"
            UserDefaults.standard.set(newUserName, forKey: self.keyUserName)
            self.fillUserName()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "setUserName"), object: nil, userInfo: ["userName" : newUserName])
        }))
        alert.addTextField { textfield in
            textfield.placeholder = "Новое имя для \(UserDefaults.standard.string(forKey: self.keyUserName) ?? "User")"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fillUserName() {
        do {
            let userDefaultName = UserDefaults.standard.string(forKey: keyUserName)
            let userString = try NSAttributedString(
                markdown:"**\(userDefaultName ?? "User")**")
            let label = UILabel()
            label.attributedText = userString
            label.font = UIFont(name: "BrahmsGotischCyrRegular", size: 30)
            navigationItem.titleView = label
        } catch {
            print("Couldn't parse: \(error)")
        }
    }
    
}
