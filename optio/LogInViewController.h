//
//  LogInViewController.h
//  optio
//
//  Created by Robert Mannuzza on 9/19/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
//#import "FBSDKLoginKit.h"



@interface LogInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *joinButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButtonFB;

@end
