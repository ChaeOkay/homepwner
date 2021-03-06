//
//  CODetailViewController.m
//  HomePwner
//
//  Created by Chae O'Keefe on 3/18/14.
//  Copyright (c) 2014 ChaeOkay. All rights reserved.
//

#import "CODetailViewController.h"
#import "BNRItem.h"
#import "COImageStore.h"

@interface CODetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation CODetailViewController

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageTaken = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = imageTaken;

    COImageStore *images = [COImageStore imageStore];
    NSString *newImageName = self.item.serialNumber;
    [images setImage:imageTaken forKey:[newImageName stringByAppendingString:@"IMG"]];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];

    static NSDateFormatter *date;
    if (!date){
        date = [NSDateFormatter new];
        date.dateStyle = NSDateFormatterMediumStyle;
        date.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [date stringFromDate:item.dateCreated];

    NSString *imageKey = [self.item.serialNumber stringByAppendingString:@"IMG"];

    UIImage *image = [[COImageStore imageStore] imageForKey:imageKey];
    if (image)
    {
        self.imageView.image = image;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = item.itemName;
}

- (IBAction)tapped
{
    NSLog(@"tappage!");
}

@end
