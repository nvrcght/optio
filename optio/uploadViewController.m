//
//  uploadViewController.m
//  optio
//
//  Created by Robert mannuzza on 9/20/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import "uploadViewController.h"
#import "SWRevealViewController.h"
#import "PFFile.h"
#import "PFObject.h"
#import "PFUser.h"

@interface uploadViewController () {
    NSMutableArray *hourPickerData;
    NSMutableArray *minPickerData;
    int hours;
    int mins;
    PFFile *img1;
    PFFile *img2;
    CGRect img1OS;
    CGRect img2OS;
    CGRect imgOS;
    int imgPicked;
    bool isYesNo;
    
}

@end

@implementation uploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self setUpPickerData];
    [self setupPickerViews];
    [self setupCGRects];
    self.choiceOneImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(imageOneChoose:)];
    tapGesture1.numberOfTapsRequired = 1;
    [tapGesture1 setDelegate:self];
    [self.choiceOneImage addGestureRecognizer:tapGesture1];
    
    self.choiceTwoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(imageTwoChoose:)];
    tapGesture2.numberOfTapsRequired = 1;
    [tapGesture2 setDelegate:self];
    [self.choiceTwoImage addGestureRecognizer:tapGesture2];
    imgPicked = 1;
    isYesNo = TRUE;
}

- (void)imageOneChoose: (id)sender {
    //handle Tap...
    imgPicked = 1;
    NSLog(@"imageOneChoose");
    [self selectPhoto];
}
- (void)imageTwoChoose: (id)sender {
    //handle Tap...
    imgPicked = 2;
    NSLog(@"imageTwoChoose");
    [self selectPhoto];
}
- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)selectPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Image seletected");
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0f);
    PFFile *file = [PFFile fileWithData:imageData];
    if (imgPicked == 1) {
        NSLog(@"here is 1");
        img1 = file;
        [img1 saveInBackground];
        [self.choiceOneImage setImage:chosenImage];
    }
    if (imgPicked == 2) {
        NSLog(@"here is 2");
        img2 = file;
        [img2 saveInBackground];
        [self.choiceTwoImage setImage:chosenImage];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)setupCGRects {
    imgOS = CGRectMake(
                       self.choiceOneImage.frame.origin.x, self.choiceOneImage.frame.origin.y,
                       self.choiceOneImage.frame.size.width, self.choiceOneImage.frame.size.height
                       );
    img1OS = CGRectMake(
                        - self.choiceTwoImage.frame.origin.x, self.choiceOneImage.frame.origin.y,
                       self.choiceOneImage.frame.size.width, self.choiceOneImage.frame.size.height
                       );
    img2OS = CGRectMake(
                        self.choiceTwoImage.frame.origin.x, self.choiceOneImage.frame.origin.y,
                        self.choiceOneImage.frame.size.width, self.choiceOneImage.frame.size.height
                       );
    
}
- (void)setupPickerViews {
    [self.hoursPicker setDelegate:self];
    [self.hoursPicker setDataSource:self];
    [self.minsPicker setDelegate:self];
    [self.minsPicker setDataSource:self];
}
- (void)setUpPickerData {
    hours = 0;
    mins = 0;
    minPickerData = [[NSMutableArray alloc] init];
    hourPickerData = [[NSMutableArray alloc] init];
    for (int x = 0; x < 61; x++) {
        [minPickerData addObject:[NSString stringWithFormat:@"%i", x]];
    }
    for (int x = 0; x < 25; x++) {
        [hourPickerData addObject:[NSString stringWithFormat:@"%i", x]];
    }
}



// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 0) {
        return hourPickerData.count;
    }
    if (pickerView.tag == 1) {
        return minPickerData.count;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    if (pickerView.tag == 0) {
        hours = [[hourPickerData objectAtIndexedSubscript:row] intValue];
    }
    if (pickerView.tag == 1) {
        mins = [[minPickerData objectAtIndexedSubscript:row] intValue];
    }
    NSLog(@"hours: %i, mins: %i", hours, mins);
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 0) {
        return [hourPickerData objectAtIndexedSubscript:row];
    }
    if (pickerView.tag == 1) {
        return [minPickerData objectAtIndexedSubscript:row];
    }
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadTypeChanged:(id)sender {
    if ([self.uploadType selectedSegmentIndex] == 0) {
        [self.choicePicker setHidden:YES];
        [self showImageOne];
        isYesNo = YES;
    } else {
        [self.choicePicker setHidden:NO];
        isYesNo = NO;
    }
}

- (IBAction)displayImageOneOrTwo:(id)sender {
    if ([self.choicePicker selectedSegmentIndex] == 0) {
        [self showImageOne];
    } else {
        [self showImageTwo];
    }
}

- (void)showImageOne {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.choiceOneImage.frame = imgOS;
        self.choiceTwoImage.frame = img2OS;
    } completion:^(BOOL finished) {
    }];

}
- (void)showImageTwo {
    [UIView animateWithDuration:0.2 animations:^{
        self.choiceTwoImage.frame = imgOS;
        self.choiceOneImage.frame = img1OS;
    } completion:^(BOOL finished) {
    }];
}
- (IBAction)uploadPost:(id)sender {
    if (img1 != NULL) {
        NSDate *now = [NSDate date];
        NSDate *new = [now dateByAddingTimeInterval:60*60*hours + (mins*60)];
        PFObject *uploadpost = [PFObject objectWithClassName:@"uploadedPosts"];
        uploadpost[@"destroyAt"] = new;
        uploadpost[@"isYesNo"] = [NSNumber numberWithBool:isYesNo];
        uploadpost[@"img1"] = img1;
        if (isYesNo == 0 && img2 != NULL) {
            uploadpost[@"img2"] = img2;
        }
        uploadpost[@"userName"] = [[PFUser currentUser] username];
        [uploadpost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                // yeaaaaaaaaaa
            } else {
                //do some shit with the error
            }
        }];
    } else {
        NSLog(@"Images are null");
    }
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
