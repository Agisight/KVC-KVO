//
//  Person.h
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

#import <Foundation/Foundation.h>
#import "Account.h"

// Идетичные объявления конекстов
static void *const _Nonnull PersonAccountBalanceContext = (void *)&PersonAccountBalanceContext;
static void *const _Nonnull PersonAccountLastTransactionContext = (void *)&PersonAccountLastTransactionContext;
static void * _Nonnull PersonFullNameContext = &PersonFullNameContext;
static void * _Nonnull PersonNumberOfTransactionsContext = &PersonNumberOfTransactionsContext;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (instancetype)initWithfirstName:(NSString*)firstName lastName:(NSString*)lastName;
- (instancetype)initWithfirstName:(NSString*)firstName lastName:(NSString*)lastName account:(Account*)account;

@property Account* account;
-(NSString*) fullName;
@property int numberOfTransactions;
@end

NS_ASSUME_NONNULL_END
