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
#import <STTwitter/STTwitter.h>

@interface HomeVC ()

@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSString *reslt;

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
    
    [self twitterUser:[self twittertimeline]];
    
}


-(void)twitterUser:(NSString *)screenName{
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"jMlimKVWSxjid4KFE5klB7m3L" consumerSecret:@"lDIt8hpMnocShUn1ZTKBsWY1W0e091qygJV5YR4N9mJXSzA17K"];
                             
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        [twitter getUserInformationFor:screenName successBlock:^(NSDictionary *user) {
            
            NSLog(@"%@",user);//user data cames as NSDictionary and we're printing it to log.
             
        } errorBlock:^(NSError *error) {
            
            NSLog(@"%@",error.debugDescription);
            
        }];
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error.debugDescription);
        
    }];
     
}
     


-(NSString *)twittertimeline{
    
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
                                              NSURL *requestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                                              
                                              NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                                              
                                              [parameters setObject:@"100" forKey:@"count"];
                                              [parameters setObject:@"1" forKey:@"include_entities"];
                                              
                                              SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPI parameters:parameters];
                                              
                                              posts.account = twitterAccount;
                                              
                                              self.reslt = twitterAccount.username;
                                              
                                              [posts performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                  
                                                  self.array = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                                                  if (self.array.count != 0) {
                                                      
                                                      NSLog(@"%@",self.array);
                                                      
                                                  }
                                                  
                                                  
                                              }];
                                              
                                          }
                                      }else{
                                          
                                          NSLog(@"%@", [error localizedDescription]);
                                          
                                      }
                                    }];
    return self.reslt;
}
@end