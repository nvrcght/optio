//
//  LogInViewController.m
//  optio
//
//  Created by Robert Mannuzza on 9/19/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController
@synthesize loginButton, joinButton, usernameField, passwordField, forgotButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"CurrentUser: %@", currentUser.email);
}

- (IBAction)logInButtonPressed:(id)sender {
    [PFUser logInWithUsernameInBackground:[self.usernameField text] password:[self.passwordField text]
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"Log In Successfull");
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
                                    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
