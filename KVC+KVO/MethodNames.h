//
//  MethodNames.h
//  KVC+KVO
//
//  Created by Work on 11.04.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Объявление константы на Objective-C
static NSString *const kMyConstant = @"myMethod";

// Объявление констант в Objective-C
typedef NSString *MethodNames NS_STRING_ENUM;
static MethodNames const kMethodNamesMyMethod = @"myMethod";
static MethodNames const kMethodNamesSecond = @"SecondMethod";
static MethodNames const kMethodNamesThird = @"ThirdMethod";

NS_ASSUME_NONNULL_END
