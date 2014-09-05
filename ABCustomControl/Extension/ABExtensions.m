//
//  ABExtensions.m
//  ABCustomControl
//
//  Created by Amit Kumar Barman on 8/22/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import "ABExtensions.h"

@implementation NSBundle (CIG)

+ (NSBundle *)mainBundleCore {
    static NSBundle* coreBundle = nil;
    if (!coreBundle) {
        NSLog(@"%@", [[NSBundle mainBundle] resourcePath]);
        NSString *coreBundlePath = [[NSBundle mainBundle] pathForResource:@"ABResourceBundle"
                                                                   ofType:@"bundle"];
        coreBundle = [NSBundle bundleWithPath:coreBundlePath];
    }
    return coreBundle;
}

@end


@implementation NSIndexPath (CIG)

+ (NSIndexPath*)indexPathForTag:(NSInteger)tag
{
    NSUInteger section = (tag & 0xFFFF0000) >> 16;
    NSUInteger row = (tag & 0xFFFF);
    
    return [self indexPathForRow:row inSection:section];
}

- (NSInteger)tag
{
    NSUInteger section = (self.section & 0xFFFF) << 16;
    NSUInteger row = (self.row & 0xFFFF);
    
    return section | row;
}

+ (NSArray *)indexPathsForRowsInRange:(NSRange)rows inSection:(NSUInteger)section
{
    NSMutableArray* indexPaths = [NSMutableArray array];
    
    NSUInteger row = rows.location;
    for (NSUInteger currentIndex = 0; currentIndex < rows.length; ++currentIndex)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:indexPath];
        ++row;
    }
    
    return indexPaths;
}

@end