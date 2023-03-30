//
//  ViewController.m
//  KVC+KVO
//
//  Created by Work on 29.03.2023.
//

#import "Person.h"
#import "ViewController.h"

@interface ViewController ()
@property Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[Person alloc] initWithfirstName:@"Alex" lastName:@"Sat"];
    
    NSString *lastName = [self.person valueForKey:@"lastName"];
    NSString *fullName = self.person.fullName;
    [self setTitle:fullName];
    [self.tabBarItem setBadgeColor:UIColor.redColor];
    
    [self.person addObserver:self forKeyPath:@"fullName" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:PersonFullNameContext];
    
    [self.person addObserver:self forKeyPath:@"numberOfTransactions" options:(NSKeyValueObservingOptionNew) context:PersonNumberOfTransactionsContext];
    
    [self.person.account addObserver:self
                          forKeyPath:@"balance"
                             options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
                             context:PersonAccountBalanceContext];
    
    NSLog(@"LastName: %@, fullName = %@", lastName, fullName);
    // LastName: Sat, fullName = Alex Sat
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"fullName" context:PersonFullNameContext];
    [self.person removeObserver:self forKeyPath:@"numberOfTransactions" context:PersonNumberOfTransactionsContext];
    [self.person.account removeObserver:self forKeyPath:@"balance" context:PersonAccountBalanceContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == PersonAccountBalanceContext) {
        _balanceLabel.text = [NSString stringWithFormat:@"$%@", change[@"new"]];
    } else if (context == PersonFullNameContext) {
        [self setTitle:change[@"new"]];
    } else if (context == PersonNumberOfTransactionsContext) {
        self.tabBarController.tabBar.items.firstObject.badgeValue = [change[@"new"] stringValue];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (IBAction)transferMoney:(UIButton *)sender {
    [self.person.account addMoney:5];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"profile"]) {
        [segue.destinationViewController setValue:self.person forKey:@"person"];
    }
}

@end
