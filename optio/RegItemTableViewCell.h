//
//  RegItemTableViewCell.h
//  optio
//
//  Created by Robert mannuzza on 9/20/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegItemTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *name;
@end
