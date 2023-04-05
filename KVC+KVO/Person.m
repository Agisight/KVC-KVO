//
//  Person.m
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

#import "Person.h"

@interface Person ()
// Private properties
@property (nonatomic) NSString* lastName;
@property (nonatomic) NSString* firstName;
@end

@implementation Person

- (instancetype)initWithfirstName:(NSString*)firstName lastName:(NSString*)lastName {
    self = [super init];
    if (self) {
        // TODO: Inject with init or restore from database
        Account *account = [[Account alloc] init];
        account.balance = 0;
        account.lastTransactionDate = NSDate.now;
        self.account = account;
        return [self initWithfirstName:firstName lastName:lastName account:account];
    }
    return self;
}

- (instancetype)initWithfirstName:(NSString*)firstName lastName:(NSString*)lastName account:(Account*)account {
    self = [super init];
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.account = account;
        
        [account addObserver:self
                  forKeyPath:@"lastTransactionDate"
                     options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
                     context:PersonAccountLastTransactionContext];
    }
    return self;
}

- (void)setFirstName:(NSString *)newFirstName {
    [self willChangeValueForKey:@"fullName"];
    
    _firstName = newFirstName;
    
    [self didChangeValueForKey:@"fullName"];
}

- (void)setLastName:(NSString *)newLastName {
    [self willChangeValueForKey:@"fullName"];
    
    _lastName = newLastName;
    
    [self didChangeValueForKey:@"fullName"];
}

-(NSString*) fullName {
    NSString *firstName = [self valueForKey:@"firstName"];
    NSString *lastName = [self valueForKey:@"lastName"];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    return  fullName;
}

-(void) printName {
    NSString *fullName = [self fullName];
    
    NSLog(@"Full name of the person = %@", fullName);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == PersonAccountBalanceContext) {
        NSLog(@"Balance was changed %@", change[@"new"]);
    } else if (context == PersonAccountLastTransactionContext) {
        self.numberOfTransactions += 1;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
