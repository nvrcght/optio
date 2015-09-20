//
//  LeftDrawerTableViewController.m
//  optio
//
//  Created by Robert mannuzza on 9/19/15.
//  Copyright © 2015 Anush Pogosyan. All rights reserved.
//

#import "LeftDrawerTableViewController.h"
#import "SWRevealViewController.h"
#import "ProfileTableViewCell.h"
#import "RegItemTableViewCell.h"
#import "uploadViewController.h"
#import "PFUser.h"
#import "PFFile.h"


@interface LeftDrawerTableViewController () {
    NSArray *menuItems;
    ProfileTableViewCell *profPicCell;
}

@end

@implementation LeftDrawerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    menuItems = @[@"Active Optio", @"Popular", @"Upload", @"My Active"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuItems count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        profPicCell = [tableView dequeueReusableCellWithIdentifier:@"profilePic" forIndexPath:indexPath];
        profPicCell.username.text = [NSString stringWithFormat:@"@%@",[[PFUser currentUser] username]];
        PFFile *userImageFile = [[PFUser currentUser] objectForKey:@"profilePic"];
        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:imageData];
                [profPicCell.profilePic setBackgroundImage:image forState:UIControlStateNormal];
                NSLog(@"downloadComplete");
            }
        }];
        return profPicCell;
    } else {
        RegItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regItem" forIndexPath:indexPath];

        cell.name.text = [menuItems objectAtIndex:indexPath.row - 1];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //do something with profile maybe
    } else {
        RegItemTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 1:
                //feed
                NSLog(@"feed");
                [self performSegueWithIdentifier:@"activeScreen" sender: self];
                break;
            case 2:
                //popular
                NSLog(@"popular");
                break;
            case 3:
                //upload
                NSLog(@"upload");
                [self performSegueWithIdentifier:@"uploadScreen" sender: self];
                break;
            case 4:
                //my active
                NSLog(@"myactive");
                
                break;
            default:
                break;
        }
    }
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
    PFUser *user = [PFUser currentUser];
    [user setObject:file forKeyedSubscript:@"profilePic"];
    [user saveInBackground];
    [profPicCell.profilePic setBackgroundImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)profilePicClicked:(id)sender {
    [self selectPhoto];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Space cell's height
    if (indexPath.row == 0) {
        return 190.0f;
    }
    
    // Content cell's height
    else {
        return 50.0f;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"uploadScreen"]) {
    }
}


@end
