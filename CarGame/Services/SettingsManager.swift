//
//  SettingsManager.swift
//  CarGame
//
//  Created by Артём Черныш on 10.07.23.
//

import Foundation
import AVFoundation

class SettingsManager {
    public static var management = SettingsManager.init()
    
    public var musicChecked: [Bool] = []
    public var difficultyChecked: [Bool] = []
    var player: AVAudioPlayer?
    var score: Int?
    private init() { }
}
