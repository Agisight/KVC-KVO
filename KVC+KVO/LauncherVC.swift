//
//  LauncherVC.swift
//  KVC+KVO
//
//  Created by Work on 11.04.2023.
//

import UIKit

/**
 The example to create a custom classes in runtime and use it in a ViewController
 */

final class LauncherVC: UIViewController {
    private enum Const {
        static let className = "Launcher"
        static let propertyName = "rocketSpeed"
    }
    private var launcher: AnyObject!
    @IBOutlet private var rocketSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launcher = createLauncher()
        launcher.setValue("100500", forKey: Const.propertyName)
        let speed = launcher.value(forKey: Const.propertyName) as? String ?? "0"
        debugPrint(speed)
    }
    
    @IBAction private func launchRocket() {
        // Вызываем метод
        let selector1 = NSSelectorFromString(kMyConstant)
        _ = launcher.perform(selector1)
    }
    
    private func createLauncher() -> AnyObject {
        let variable = Const.propertyName
        let newClass: AnyClass = RuntimeAddClass.generateNewClass(
            Const.className,
            variable: variable,
            method: { [weak self] object in
                let speed = object.value(forKey: Const.propertyName) as? String ?? "0"
                self?.rocketSpeedLabel.text = "The rocket has launched with speed = \(speed)"
                
                debugPrint("Запуск ракеты со скоростью \(speed)!")
            }
        )
        
        // Создаем экземпляр класса MyClass
        let instance = newClass.alloc()
        // Можно устанавливать значение переменной экземпляра
        object_setIvar(launcher, class_getInstanceVariable(newClass, variable)!, "1");
        // Или так через KVC
        instance.setValue("10", forKey: variable)

        return instance
    }
}
