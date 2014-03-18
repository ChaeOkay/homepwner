//
//  COImageStore.m
//  HomePwner
//
//  Created by Chae O'Keefe on 3/18/14.
//  Copyright (c) 2014 ChaeOkay. All rights reserved.
//

#import "COImageStore.h"

@interface COImageStore()

@property (nonatomic, strong) NSMutableDictionary *imageCollection;

@end

@implementation COImageStore

+ (instancetype)imageStore
{
    static COImageStore *me;
    if (!me)
    {
        me = [[self alloc] initPrivate];
    }

    return me;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _imageCollection = [NSMutableDictionary new];
    }

    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.imageCollection[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    return self.imageCollection[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        NSLog(@"No image found for removale");
        return;
    }

    [self.imageCollection objectForKey:key];
}

@end
