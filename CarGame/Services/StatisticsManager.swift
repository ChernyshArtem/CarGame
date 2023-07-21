//
//  StatisticsManager.swift
//  CarGame
//
//  Created by Артём Черныш on 21.07.23.
//

import Foundation

class StatisticsManager {
    public static let management = StatisticsManager()
    private init () { }
    public var listOfWinners: [(String,Int)] = [("Кики", 45000), ("Максим", 39977), ("Сэм", 38951), ("Тимон", 37898), ("Луи", 34873), ("Бэйли", 31842), ("Рокки", 29817), ("Лола", 29774), ("Грейп", 29704), ("Харли", 28682), ("Кики", 25661), ("Джесси", 23598), ("Бобо", 22569), ("Зои", 20556), ("Оливия", 19508), ("Нико", 19487), ("Лео", 17409), ("Мила", 16382), ("Кэти", 9287), ("Бенджи", 9209)]
    
    public func sortList() {
        for _ in 0..<listOfWinners.count - 1 {
            for i in 0..<listOfWinners.count - 1 {
                if listOfWinners[i].1 < listOfWinners[i+1].1 {
                    let copyArr = listOfWinners[i]
                    listOfWinners[i] = listOfWinners[i+1]
                    listOfWinners[i+1] = copyArr
                }
            }
        }
    }
    
    public func addWinnerToList(score: Int) -> String {
        if score < 100 {
            return "Вы настолько слабы что не набрали 100 очков. ХА-ха-ХА"
        } else {
            listOfWinners.append(("User", score))
            sortList()
            return "Поздравляю, вы набрали \(score) очков и попали в список победителей"
        }
    }
}
