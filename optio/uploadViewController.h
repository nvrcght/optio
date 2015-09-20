//
//  uploadViewController.h
//  optio
//
//  Created by Robert mannuzza on 9/20/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uploadViewController : UIViewController < UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *uploadType;
@property (strong, nonatomic) IBOutlet UIPickerView *hoursPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *minsPicker;
@property (strong, nonatomic) IBOutlet UIImageView *choiceOneImage;
@property (strong, nonatomic) IBOutlet UISegmentedControl *choicePicker;
@property (strong, nonatomic) IBOutlet UIImageView *choiceTwoImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
