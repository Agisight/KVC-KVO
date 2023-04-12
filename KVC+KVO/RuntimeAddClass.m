//
//  RuntimeAddClass.m
//  KVC+KVO
//
//  Created by Work on 11.04.2023.
//

#import <objc/runtime.h>
#import "MethodNames.h"
#import "RuntimeAddClass.h"

@implementation RuntimeAddClass

+(Class)generateNewClass:(const char * _Nonnull)className variable:(const char * _Nonnull)variableName method:(void(^)(NSObject*)) block {
    // Создаем новый класс MyClass
    Class newClass = objc_allocateClassPair([NSObject class], className, 0);

    // Добавляем переменную экземпляра
    class_addIvar(newClass, variableName, sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
    // Можно добавлять любые переменные как тут
    class_addIvar(newClass, "defaultVariable", sizeof(id), log2(sizeof(id)), @encode(id));

    // Добавляем метод
    SEL myMethodSelector = sel_registerName([kMethodNamesMyMethod UTF8String]);
    IMP myMethodImplementation = imp_implementationWithBlock(block);
    class_addMethod(newClass, myMethodSelector, myMethodImplementation, "v@:");

    // Завершаем создание класса
    objc_registerClassPair(newClass);
    return newClass;
}

@end
