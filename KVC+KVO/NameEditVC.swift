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
    
    @IBOutlet private weak var balancesSumLabel: UILabel!
    
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
    
    // Показываем обработку массивов с помощью операторов
    @IBAction private func testPersonsArray() {
        debugPrint("--- Test ---")
        let dinDjarinAccount = Account(balance: 2000)
        let dinDjarin = Person(firstName: "Din", lastName: "Djarin", account: dinDjarinAccount)
        
        let groguBabyAccount = Account(balance: 0)
        let groguBaby = Person(firstName: "Grogu", lastName: "Baby", account: groguBabyAccount)
        
        let soloKhanAccount = Account(balance: .random(in: 100...500))
        let soloKhan = Person(firstName: "Solo", lastName: "Khan", account: soloKhanAccount)
        
        let anakinSkywalkerAccount = Account(balance: 9000)
        let anakinSkywalker = Person(firstName: "Anakin", lastName: "Skywalker", account: anakinSkywalkerAccount)
        
        let leiaSkywalkerAccount = Account(balance: 5000)
        let leiaSkywalker = Person(firstName: "Leia", lastName: "Skywalker", account: leiaSkywalkerAccount)
        
        let lukeSkywalkerAccount = Account(balance: 1000)
        let lukeSkywalker = Person(firstName: "Leia", lastName: "Skywalker", account: lukeSkywalkerAccount)
        
        let persons = NSArray(array: [
            dinDjarin, groguBaby, soloKhan, anakinSkywalker, leiaSkywalker, lukeSkywalker
        ])
        let uniqueFirstNames = persons.value(forKeyPath: "@distinctUnionOfObjects.lastName") as? [String] ?? []
        // Только уникальные фамилии
        debugPrint(uniqueFirstNames)
        
        let avgPersonsBalance = persons.value(forKeyPath: "@avg.account.balance") as? Double ?? 0
        // Средний баланс у персон
        debugPrint(avgPersonsBalance)
        
        let sumPersonsBalance = (persons.value(forKeyPath: "@sum.account.balance") as? Double ?? 0).rounded()
        // Сумма всех балансов
        debugPrint(sumPersonsBalance)
        balancesSumLabel.text = "\(sumPersonsBalance)"
    }
}
