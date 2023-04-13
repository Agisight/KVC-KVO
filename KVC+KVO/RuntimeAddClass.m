//
//  RuntimeAddClass.m
//  KVC+KVO
//
//  Created by Work on 11.04.2023.
//

#import "MethodNames.h"
#import "RuntimeAddClass.h"
#import <objc/runtime.h>

@implementation RuntimeAddClass

+(Class)generateNewClass:(const char * _Nonnull)className variable:(const char * _Nonnull)variableName method:(void(^)(NSObject*)) block {
    // Создаем новый класс с именем в `className`
    Class newClass = objc_allocateClassPair([NSObject class], className, 0);

    // Добавляем переменную экземпляра типа NSString
    class_addIvar(newClass, variableName, sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));

    // Добавляем метод
    SEL myMethodSelector = sel_registerName([kMethodNamesMyMethod UTF8String]);
    IMP myMethodImplementation = imp_implementationWithBlock(block);
    class_addMethod(newClass, myMethodSelector, myMethodImplementation, "v@:");

    // Завершаем создание класса
    objc_registerClassPair(newClass);
    
    return newClass;
}

@end
