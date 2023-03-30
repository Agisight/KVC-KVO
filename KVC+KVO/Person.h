//
//  Person.h
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

#import <Foundation/Foundation.h>
#import "Account.h"

static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;
static void *PersonAccountLastTransactionContext = &PersonAccountLastTransactionContext;
static void *PersonFullNameContext = &PersonFullNameContext;
static void *PersonNumberOfTransactionsContext = &PersonNumberOfTransactionsContext;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (instancetype)initWithfirstName:(NSString*)firstName lastName:(NSString*)lastName;

@property Account* account;
-(NSString*) fullName;
@property int numberOfTransactions;
@end

NS_ASSUME_NONNULL_END
