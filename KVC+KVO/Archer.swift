//
//  Archer.swift
//  KVC+KVO
//
//  Created by Work on 10.04.2023.
//

import Foundation

@objc enum SkillLevel: Int, CaseIterable {
    typealias RawValue = Int
    case newbie
    case beginner
    case candidate
    case master
    case champion
    
    var stringValue: String {
        switch self {
        case .newbie:
            return "newbie"
        case .beginner:
            return "beginner"
        case .candidate:
            return "candidate"
        case .master:
            return "master"
        case .champion:
            return "champion"
        }
    }
    
    var capitalized: String {
        stringValue.capitalized
    }
}

// Создание класса с наблюдаемым свойством
final class Archer: NSObject {
    @objc dynamic var skillLevel: Int = 0
    
    @objc dynamic var title: SkillLevel = .newbie {
        didSet {
            if title.rawValue > oldValue.rawValue {
                debugPrint("Congratulation! You are \(title.stringValue)")
            } else {
                debugPrint("Ouch! You should try more, \(title.stringValue)")
            }
        }
    }
    
    @objc func shoot(_ speed: Float) -> Bool {
        if speed >= 100500 {
            debugPrint("Too large speed to shoot by the archer = \(speed)")
            return false
        }
        
        debugPrint("Archer fired with arrow speed = \(speed)")
        return true
    }
}
