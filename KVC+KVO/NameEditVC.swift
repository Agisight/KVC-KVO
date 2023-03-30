//
//  NameEditVC.swift
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

import UIKit

/**

 Простой контроллер по работе с `KVC` объекта `Person: NSObject` из `ObjC`.
 Также здесь добавили `@objc dynamic` к `person`, чтобы отслеживать изменения переменной `person` и его свойств – KVO.
 
 Внизу показана работы следующих возможностей:
    - получение значения через `key`
    - назначение значения через `key`
    - использование `setValuesForKeys`
    - получение значения через `keyPath`
 
*/

final class NameEditVC: UIViewController {
    @objc dynamic public weak var person: Person!
    
    @IBOutlet private weak var firstNameTF: UITextField!
    @IBOutlet private weak var lastNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.text = person.value(forKey: "firstName") as? String
        lastNameTF.text = person.value(forKey: "lastName") as? String
    }
    
    @IBAction private func renameName() {
        // Задание значения нужной переменной через `key`
        person.setValue(firstNameTF.text, forKey: "firstName")
        person.setValue(lastNameTF.text, forKey: "lastName")
        
        // Через `keyPath` есть аналогичный метод
        setValue(lastNameTF.text, forKeyPath: "person.lastName")
        
        // То же самое, но в одном вызове `setValuesForKeys`
        person.setValuesForKeys([
            "firstName": firstNameTF.text ?? "",
            "lastName": lastNameTF.text ?? ""
        ])
        
        // Получение значения нужной переменной через `keyPath`
        let fullname = value(forKeyPath: "person.fullName") ?? ""
        debugPrint("Full name is \(fullname)")
    }
}
