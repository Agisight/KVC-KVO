//
//  ReflectionTest.m
//  KVC+KVO
//
//  Created by Work on 12.04.2023.
//

#import "KVC_KVO-Swift.h"
#import "ReflectionTest.h"

@implementation ReflectionTest

+(void) printArcherClassInfo {
    // Получаем класс Archer
    Class stringClass = [Archer class];

    // Получаем имя класса
    const char *className1 = class_getName(stringClass);
    NSLog(@"Имя класса: %s", className1);

    // Получаем количество методов класса
    unsigned int count;
    Method *methods = class_copyMethodList(stringClass, &count);
    NSLog(@"Количество методов: %u", count);

    // Выводим информацию о каждом методе
    for (unsigned int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        const char *methodName = sel_getName(selector);
        NSLog(@"Метод: %s", methodName);
    }

    // Освобождаем память, выделенную под массив методов
    free(methods);
    
    [self createArcherInstanceFromString];
}

/// Создание экземпляра класса по ссылке на объект класса (`Class`)
+(void) createArcherInstanceFromString {
    // Предположим, что нашли класс извне или из списка зарегистрированных классов
    Class archerClass = [Archer class];
    
    // Создаем экземпляр класса Archer
    id archer = [[archerClass alloc] init];

    // Получаем селектор геттера title
    SEL selector = NSSelectorFromString(@"shoot:");

    NSNumber *speed = [NSNumber numberWithFloat:100500];
    // Вызываем метод
    BOOL successShot = [archer performSelector:selector withObject: speed];
    NSLog(@"Результат выстрела лучника 1: %@", successShot ? @"YES" : @"NO");
    
    speed = [NSNumber numberWithFloat:2023];
    // Другой способ вызова селектора, но через его типизацию (во избежание предупреждения `PerformSelector may cause a leak because its selector is unknown`
    if ([archer respondsToSelector:selector]) {
        typedef BOOL (*MethodType)(id, SEL, id);
        MethodType method = (MethodType)[archer methodForSelector:selector];
        successShot = method(archer, selector, speed);
        NSLog(@"Результат выстрела лучника 2: %@", successShot ? @"YES" : @"NO");
    }
}
@end
