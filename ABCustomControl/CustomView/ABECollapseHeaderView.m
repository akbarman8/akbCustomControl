//
//  ABECollapseHeaderView.m
//  CignaCore
//
//  Created by Amit Barman on 03/14/14.
//  Copyright 2014 Cigna. All rights reserved.
//
//--------------------------------------------------------------------------------------------------

#import "ABECollapseHeaderView.h"
#import "ABExtensions.h"

#define ICON_SECTION_HEADER @"sectionheader"
//--------------------------------------------------------------------------------------------------
@interface ABECollapseHeaderView()

@property (nonatomic, strong) IBOutlet UIImageView*	arrowImage;

@end

//--------------------------------------------------------------------------------------------------
@implementation ABECollapseHeaderView

+ (ABECollapseHeaderView*)expandableHeaderViewWithSection:(NSInteger)section {
    static ABECollapseHeaderView* headerView = nil;
    if (!headerView) {
        NSArray* nibObjects = [[NSBundle mainBundleCore] loadNibNamed:@"ABECollapseHeaderView"
                                                                owner:nil
                                                              options:nil];
        headerView = [nibObjects objectAtIndex:0];
    }
	return headerView;
}


+ (CGFloat)height {
	static CGFloat height = 0.0f;
	if (height == 0.0f) {
		ABECollapseHeaderView* view = [self expandableHeaderViewWithSection:0];
		height = view.frame.size.height;
	}
	return height;
}

@end
