//
//  RuntimeAddClass.h
//  KVC+KVO
//
//  Created by Work on 11.04.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The example to create a custom classes in runtime
 */

@interface RuntimeAddClass : NSObject

/**
 Generating a custom class with simple bulder in runtime
 */

+(Class)generateNewClass:(const char * _Nonnull)className variable:(const char * _Nonnull)variableName method:(void(^)(NSObject*)) block;
@end

NS_ASSUME_NONNULL_END
