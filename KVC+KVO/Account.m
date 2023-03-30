//
//  Account.m
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

#import "Account.h"

@interface Account ()

@end

@implementation Account

-(void)addMoney:(double) amount {
    _balance += amount;
    
    [self setBalance:_balance];
    [self setLastTransactionDate:NSDate.now];
}
@end
