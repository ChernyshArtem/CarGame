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
        musicChecked?[0] = true
        difficultyChecked?[1] = true
    }
}
