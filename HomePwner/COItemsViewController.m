//
//  COItemsViewController.m
//  HomePwner
//
//  Created by Chae O'Keefe on 3/18/14.
//  Copyright (c) 2014 ChaeOkay. All rights reserved.
//

#import "COItemsViewController.h"

@implementation COItemsViewController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    [NSException raise:@"Invalid Initializer" format:@"Please use init, does not support super custom extremely amazing styles"];
    return nil;
}

@end
