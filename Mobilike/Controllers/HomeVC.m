//
//  HomeVC.m
//  Mobilike
//
//  Created by Erkan Eren on 28/07/14.
//
//

#import "HomeVC.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface HomeVC ()

@property (strong, nonatomic) NSArray *array;

@end

@implementation HomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTwitterTapped:(UIButton *)sender {
    
    [self twittertimeline];
    
}
 	


-(void)twittertimeline{
    
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType options:nil
                                  completion:^(BOOL granted, NSError *error)
                                    {
                                      if (granted == YES) {
                                          NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
                                          
                                          if ([arrayOfAccounts count] > 0)
                                          {
                                              ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                                              // so smthg with accounts
                                          }
                                      }
                                    }];
    
    
    
}
@end






























