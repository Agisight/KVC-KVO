//
//  KVOExample.swift
//  KVC+KVO
//
//  Created by Work on 30.03.2023.
//

import Foundation
import SwiftUI

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
}

/**
    В этом классе приводим примеры создания Swift-style наблюдателей `NSKeyValueObservation`.
 
 Созданы 2 наблюдателя: один для `Int`,  другой для `enum`.
 В случае `enum` приводим его к согласованию для наблюдаемости (должен иметь RawValue = Int), а также иметь аттрибут`@objc` и модификатор `dynamic`.
 
*/
final class KVOExample: NSObject {
    var observation: NSKeyValueObservation!
    var observation2: NSKeyValueObservation!
    @objc dynamic var archer = Archer()
    
    func registerObservations() {
        // Добавление наблюдателя за свойством title объекта Archer
        observation = archer.observe(\.skillLevel, options: [.new]) { (object, change) in
            // Обработка изменения свойства
            let value = change.newValue ?? 0
            object.title = .init(rawValue: value) ?? .newbie
        }
        
        observation2 = archer.observe(\.title, options: [.new]) { (object, change) in
            /// Обработка изменения свойства, но тут для `enum` нет никаких значений в change. Почему?.
            /// Зато можно вытащить у object.title
            /// При подписке на изменения ObjC-стилем – `addObserver(...` измененные значения `enum` приходят как RawValue = Int
            
            debugPrint("Title from `change` = \(change.newValue?.stringValue ?? "Error: No title")")
            debugPrint("Your new title from `object` is \(object.title.stringValue)")
        }
    }
    
    private func doExample() {
        // KVC
        archer.setValue("Aldar", forKey: "firstName")
        setValue("Walles", forKeyPath: "archer.lastName")
        
        
        // KVO
        observation = archer.observe(
            \.skillLevel,
             options: [.old, .new]
        ) { (object, change) in
            // Обработка изменения свойства
            let value = change.newValue ?? 0
            debugPrint("Новое значение `skillLevel` = \(value)")
        }
        
    }
    
    deinit {
        removeObservations()
    }
    
    func removeObservations() {
        // Удаление наблюдателей
        observation?.invalidate()
        observation2?.invalidate()
        observation = nil
        observation2 = nil
    }
}
