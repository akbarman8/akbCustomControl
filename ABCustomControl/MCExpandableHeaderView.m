//
//  MCExpandableHeaderView.m
//  myCigna
//
//  Created by Jeff Gilbert on 9/20/11.
//  Copyright (c) 2012+ Cigna. All rights reserved.
//

#import "MCExpandableHeaderView.h"

@interface MCExpandableHeaderView()

@property (nonatomic, strong) IBOutlet UIImageView*	arrowImage;

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, copy) MCExpandableHeaderViewToggledBlock toggledBlock;

@end

@implementation MCExpandableHeaderView

+ (MCExpandableHeaderView*)expandableHeaderViewWithSection:(NSInteger)section toggledBlock:(MCExpandableHeaderViewToggledBlock)block
{
	NSArray* nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MCExpandableHeaderView" owner:nil options:nil];
	MCExpandableHeaderView* headerView = [nibObjects objectAtIndex:0];

	UIImage* backgroundImage = [UIImage imageNamed:@"sectionheader.png"];

	UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
	[headerView insertSubview:backgroundImageView atIndex:0];

	headerView.section = section;
	headerView.toggledBlock = block;

	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:headerView action:@selector(didTap)];
	[headerView addGestureRecognizer:tapGesture];

    [headerView setExpanded:NO animated:NO];

	return headerView;
}

+ (MCExpandableHeaderView*)expandableOuterHeaderViewWithSection:(NSInteger)section toggledBlock:(MCExpandableHeaderViewToggledBlock)block
{
	NSArray* nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MCExpandableOuterHeaderView" owner:nil options:nil];
	MCExpandableHeaderView* headerView = [nibObjects objectAtIndex:0];

	UIImage* backgroundImage = [UIImage imageNamed:@"sectionheader.png"];

	UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
	[headerView insertSubview:backgroundImageView atIndex:0];

	headerView.section = section;
	headerView.toggledBlock = block;

	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:headerView action:@selector(didTap)];
	[headerView addGestureRecognizer:tapGesture];

    [headerView setExpanded:NO animated:NO];

	return headerView;
}

+ (MCExpandableHeaderView*)expandableHeaderViewForPeriodWithSection:(NSInteger)section toggledBlock:(MCExpandableHeaderViewToggledBlock)block
{
	NSArray* nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MCExpandableForPeriodHeaderView" owner:nil options:nil];
	MCExpandableHeaderView* headerView = [nibObjects objectAtIndex:0];

	UIImage* backgroundImage = [UIImage imageNamed:@"sectionheader_blue.png"];

	UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
	[headerView insertSubview:backgroundImageView atIndex:0];

	headerView.section = section;
	headerView.toggledBlock = block;

	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:headerView action:@selector(didTap)];
	[headerView addGestureRecognizer:tapGesture];

    [headerView setExpanded:NO animated:NO];

	return headerView;
}

+ (CGFloat)height
{
	static CGFloat height = 0.0f;

	if (height == 0.0f)
	{
		MCExpandableHeaderView* view = [self expandableHeaderViewWithSection:0 toggledBlock:nil];
		height = view.frame.size.height;
	}

	return height;
}

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated
{
	self.expanded = expanded;
	CGFloat angle = (self.isExpanded == NO) ? M_PI + (M_PI / 2) : 0.0f;

	[UIView animateWithDuration:(animated ? 0.3 : 0.0)
					 animations:^(void) {
						 self.arrowImage.transform = CGAffineTransformMakeRotation(angle);
					 }
                     completion:^(BOOL finished) {
                         if (self.didFinishAnimationBlock) {
                             self.didFinishAnimationBlock(self);
                         }
                     }
     ];
}

- (void)toggleExpanded {
    [self setExpanded:!self.isExpanded animated:YES];
	self.toggledBlock(self.section, self.isExpanded);
}

- (void)didTap
{
    if (self.didTapBlock != nil) {
        self.didTapBlock(self);
    }
	[self toggleExpanded];
}

@end
