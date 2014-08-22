//
//  MCExpandableHeaderView.h
//  myCigna
//
//  Created by Jeff Gilbert on 9/20/11.
//  Copyright (c) 2012+ Cigna. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
	MCExpandableHeaderViewColorGray,
	MCExpandableHeaderViewColorWhite
} MCExpandableHeaderViewColor;

typedef void (^MCExpandableHeaderViewToggledBlock)(NSInteger section, BOOL isExpanded);

@interface MCExpandableHeaderView : UIView

@property (nonatomic, strong) IBOutlet UILabel*		titleLabel;
@property (nonatomic, assign, getter=isExpanded) BOOL expanded;
@property (nonatomic, copy) void(^didTapBlock)(UIView*);
@property (nonatomic, copy) void(^didFinishAnimationBlock)(UIView*);

+ (MCExpandableHeaderView*)expandableHeaderViewWithSection:(NSInteger)section toggledBlock:(MCExpandableHeaderViewToggledBlock)block;
+ (MCExpandableHeaderView*)expandableOuterHeaderViewWithSection:(NSInteger)section toggledBlock:(MCExpandableHeaderViewToggledBlock)block;
+ (MCExpandableHeaderView*)expandableHeaderViewForPeriodWithSection:(NSInteger)section toggledBlock:(MCExpandableHeaderViewToggledBlock)block;
+ (CGFloat)height;

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated;
- (void)toggleExpanded;

- (BOOL)isExpanded;

@end
