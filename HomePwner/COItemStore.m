//
//  COItemStore.m
//  HomePwner
//
//  Created by Chae O'Keefe on 3/18/14.
//  Copyright (c) 2014 ChaeOkay. All rights reserved.
//

#import "COItemStore.h"

@implementation COItemStore

+ (instancetype)sharedStore
{
    static COItemStore *sharedStore;

    if (!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }

    return sharedStore;
}

// Don't allow instantiation of this class
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [COItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    return [super init];
}

@end
