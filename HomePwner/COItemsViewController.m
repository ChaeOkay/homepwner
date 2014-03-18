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

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation COItemsViewController

// table:numberOfRowsInSection:
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return COItemStore.sharedStore.allItems.count;
}

// tableView:cellForRowAtIndexPath:
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DolphinsForPretzels" forIndexPath:indexPath];

    NSArray *items = COItemStore.sharedStore.allItems;
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = item.description;

    return cell;
}

- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[COItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[COItemStore sharedStore] removeItem:item];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UIView *) headerView
{
    if (!_headerView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    return _headerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DolphinsForPretzels"];

    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
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

- (IBAction) addNewItem:(id)sender
{
    BNRItem *newItem = [[COItemStore sharedStore] createItem];
    NSInteger lastRow = [[[COItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];

    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction) toggleEditingMode:(id)sender
{
    if (self.isEditing)
    {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

@end
