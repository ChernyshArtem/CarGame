//
//  SettingsManager.swift
//  CarGame
//
//  Created by Артём Черныш on 10.07.23.
//

import Foundation

class SettingsManager {
    public static var management = SettingsManager.init()
    
    public var musicChecked: [Bool] = []
    public var difficultyChecked: [Bool] = []
    
    private init() { }
}
