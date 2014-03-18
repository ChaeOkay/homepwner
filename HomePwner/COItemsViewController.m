//
//  COItemsViewController.m
//  HomePwner
//
//  Created by Chae O'Keefe on 3/18/14.
//  Copyright (c) 2014 ChaeOkay. All rights reserved.
//

#import "COItemsViewController.h"
#import "COItemStore.h"
#import "BNRItem.h"

@interface COItemsViewController () <UITableViewDataSource>

@end

@implementation COItemsViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return COItemStore.sharedStore.allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DolphinsForPretzels"];

    NSArray *items = COItemStore.sharedStore.allItems;
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = item.description;

    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];

    if (self)
    {
        for (int i = 0; i < 5; i++){
            [[COItemStore sharedStore] createItem];
        }
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    [NSException raise:@"Invalid Initializer" format:@"Please use init, does not support super custom extremely amazing styles"];
    return nil;
}

@end
