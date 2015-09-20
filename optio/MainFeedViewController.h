//
//  MainFeedViewController.h
//  optio
//
//  Created by Robert mannuzza on 9/19/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFLogInViewController.h"
#import "PFSignUpViewController.h"

@interface MainFeedViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
