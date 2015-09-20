//
//  ProfileTableViewCell.m
//  optio
//
//  Created by Robert mannuzza on 9/20/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell
@synthesize profilePic, username;
- (void)awakeFromNib {
    // Initialization code
    NSLog(@"YPYP");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
