//
//  Account.h
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property double balance;
@property NSDate* lastTransactionDate;

-(void)addMoney:(double) amount;
@end

NS_ASSUME_NONNULL_END
