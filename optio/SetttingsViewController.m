//
//  SetttingsViewController.m
//  optio
//
//  Created by Robert mannuzza on 9/20/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import "SetttingsViewController.h"

@interface SetttingsViewController ()

@end

@implementation SetttingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)dismiss:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
