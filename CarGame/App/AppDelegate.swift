//
//  AppDelegate.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaults.standard.string(forKey: "userName") == nil {
            UserDefaults.standard.set("User", forKey: "userName")
        }
        if UserDefaults.standard.array(forKey: "musicChecked") == nil {
            var musicChecked = Array(repeating: false, count: 5)
            musicChecked[0] = true
            UserDefaults.standard.set(musicChecked, forKey: "musicChecked")
        }
        if UserDefaults.standard.array(forKey: "difficultyChecked") == nil {
            var difficultyChecked = Array(repeating: false, count: 3)
            difficultyChecked[1] = true
            UserDefaults.standard.set(difficultyChecked, forKey: "difficultyChecked")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

