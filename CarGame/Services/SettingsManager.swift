//
//  SettingsManager.swift
//  CarGame
//
//  Created by Артём Черныш on 10.07.23.
//

import Foundation
import AVFoundation

class SettingsManager {
    public static let management = SettingsManager.init()
    
    public var musicChecked: [Bool]? = Array(repeating: false, count: 5)
    public var difficultyChecked: [Bool]? = Array(repeating: false, count: 3)
    var player: AVAudioPlayer?
    private init() {
        musicChecked = (UserDefaults.standard.array(forKey: "musicChecked") ?? []) as? [Bool]
        difficultyChecked = (UserDefaults.standard.array(forKey: "difficultyChecked") ?? []) as? [Bool]
    }
}
