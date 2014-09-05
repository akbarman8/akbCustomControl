//
//  ABExtensions.h
//  ABCustomControl
//
//  Created by Amit Kumar Barman on 8/22/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (CIG)

+ (NSBundle *)mainBundleCore;

@end


@interface NSIndexPath (CIG)

/* The tag property of UIView is an NSInteger, but sometimes it is useful to store an NSIndexPath as the tag of a view when dealing with table cells.
 To do this use [indexPath tag] to generate a value from the indexPath suitable for storing in the tag property of a view.
 Later, when you need to process a view, you can turn its tag back into an indexPath using [NSIndexPath indexPathForTag:tag]
 */

// given a tag, creates an indexPath with section = tag[31:16], row = tag[15:0]
+ (NSIndexPath*)indexPathForTag:(NSInteger)tag;

// returns an integer with [31:16] = section, [15:0] = row
- (NSInteger)tag;

+ (NSArray *)indexPathsForRowsInRange:(NSRange)rows inSection:(NSUInteger)section;

@end