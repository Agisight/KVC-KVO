//
//  ArcherVC.swift
//  KVC+KVO
//
//  Created by Work on 30.03.2023.
//

import UIKit

/**

 Пример использования подписки на изменения через keyPath в стиле ObjC.
 0. Объект `KVOExample` должен быть унаследован от `NSObject`, а объекты по пути keyPath должны быть такими же `NSObject` и помечены `@objc dynamic`
 1. Для удобства создал контекст `ArcherTitleContext`, удобно при определении типа изменения
 2. По кнопке имитирую изменение `skillLevel` из другого события.
 3. Добавил место отписки изенений в `deinit`
 4. `observeValue(forKeyPath ...` в этом переопределении принимаю изменения, и обновляю `UILabel` на экране
 
*/
final class ArcherVC: UIViewController {
    
    private let ArcherTitleContext = UnsafeMutableRawPointer(bitPattern: 1)
    private let ArcherSkillLevelContext = UnsafeMutableRawPointer(bitPattern: 2)
    
    private var archerExample: KVOExample = .init()
    @IBOutlet private var archerTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        archerExample = KVOExample()
        archerExample.registerObservations()
        archerExample.archer.skillLevel = 0
        archerTitleLabel.text = archerExample.archer.title.capitalized
        archerExample.addObserver(self, forKeyPath: "archer.title", options: [.new], context: ArcherTitleContext)
        archerExample.addObserver(self, forKeyPath: "archer.skillLevel", options: [.new], context: ArcherSkillLevelContext)
    }
    
    @IBAction private func updateSkillLevel() {
        archerExample.archer.skillLevel = (SkillLevel.allCases.randomElement() ?? .newbie).rawValue
    }
    
    deinit {
        archerExample.removeObserver(self, forKeyPath: "archer.title", context: ArcherTitleContext)
        archerExample.removeObserver(self, forKeyPath: "archer.skillLevel", context: ArcherSkillLevelContext)
        archerExample.removeObservations()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        switch context {
        case ArcherTitleContext:
            let titleRawValue = (change?[.newKey] as? Int) ?? 0
            let titleValue = SkillLevel(rawValue: titleRawValue)
            archerTitleLabel.text = titleValue?.capitalized
        case ArcherSkillLevelContext:
            let skillLevel = change?[.newKey] as? Int
            debugPrint(skillLevel ?? -1)
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
