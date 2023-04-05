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

- (instancetype)initWithBalance:(double)balance {
    self = [super init];
    self.balance = balance;
    return self;
}

// Set `balance` value to 0 if nil is passing to `balance`. Evading the exception
- (void)setNilValueForKey:(NSString *)key {
    if ([key isEqualToString:@"balance"]) {
        self.balance = 0;
    }
}

// Override it to evade a fatal error
- (id)valueForUndefinedKey:(NSString *)key {
    if ([key hasPrefix:@"is"]) {
        return false;
    }
    
    return [super valueForUndefinedKey:key];
}

// Override it to evade a fatal error
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Error with the key = %@", key);
}

-(void)addMoney:(double) amount {
    _balance += amount;
    
    [self setBalance:_balance];
    [self setLastTransactionDate:NSDate.now];
}
@end
