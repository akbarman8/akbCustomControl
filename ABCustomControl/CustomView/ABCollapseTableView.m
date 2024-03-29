//
//  ABCollapseTableView.m
//  ABCollapseTableView
//  EarthQuakeAlert
//
//  Created by Amit Kumar Barman on 8/2/14.
//  Copyright (c) 2014 Dooars Solution. All rights reserved.
//
// ***********************************************************************************/

#import "ABCollapseTableView.h"

#import <objc/runtime.h>

@interface ABCollapseTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<UITableViewDataSource> collapseDataSource;
@property (nonatomic, assign) id<UITableViewDelegate> collapseDelegate;
@property (nonatomic, strong) NSMutableArray* sectionsStates;

@end

@implementation ABCollapseTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
    {
		[self setupCollapseTableView];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
    {
		[self setupCollapseTableView];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
	self = [super initWithFrame:frame style:style];
	if (self)
    {
		[self setupCollapseTableView];
	}
	return self;
}

- (void)setupCollapseTableView
{
	self.exclusiveSections = YES;
    self.shouldHandleHeadersTap = YES;
	self.sectionsStates = [[NSMutableArray alloc] init];
}

- (void)setDataSource:(id <UITableViewDataSource>)newDataSource
{
	if (newDataSource != self.collapseDataSource)
    {
		self.collapseDataSource = newDataSource;
		[self.sectionsStates removeAllObjects];
		[super setDataSource:self.collapseDataSource?self:nil];
	}
}

- (void)setDelegate:(id<UITableViewDelegate>)newDelegate
{
    if (!newDelegate) {
        return;
    }
    if (newDelegate != self.collapseDelegate)
    {
        self.collapseDelegate = newDelegate;
        [super setDelegate:self.collapseDelegate?self:nil];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
	if ([self.collapseDataSource respondsToSelector:aSelector])
    {
		return self.collapseDataSource;
	}
    if ([self.collapseDelegate respondsToSelector:aSelector])
    {
        return self.collapseDelegate;
    }
	return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (sel_isEqual(aSelector, @selector(tableView:viewForHeaderInSection:)))
    {
        return [self.collapseDelegate respondsToSelector:aSelector];
    }
    
	return [super respondsToSelector:aSelector] || [self.collapseDataSource respondsToSelector:aSelector] || [self.collapseDelegate respondsToSelector:aSelector];
}

- (void)openSection:(NSUInteger)sectionIndex animated:(BOOL)animated {
    if (sectionIndex >= [self.sectionsStates count]) {
        return;
    }
    
    if ([[self.sectionsStates objectAtIndex:sectionIndex] boolValue]) {
        return;
    }
	
	if (self.exclusiveSections) {
        NSUInteger openedSection = [self openedSection];
        
		[self setSectionAtIndex:sectionIndex open:YES];
		[self setSectionAtIndex:openedSection open:NO];
        
        if(animated) {
            NSArray* indexPathsToInsert = [self indexPathsForRowsInSectionAtIndex:sectionIndex];
            NSArray* indexPathsToDelete = [self indexPathsForRowsInSectionAtIndex:openedSection];
            
            UITableViewRowAnimation insertAnimation;
            UITableViewRowAnimation deleteAnimation;
            
            if (openedSection == NSNotFound || sectionIndex < openedSection) {
                insertAnimation = UITableViewRowAnimationTop;
                deleteAnimation = UITableViewRowAnimationBottom;
            }
            else {
                insertAnimation = UITableViewRowAnimationBottom;
                deleteAnimation = UITableViewRowAnimationTop;
            }
            [self beginUpdates];
            [self insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
            [self deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
            [self endUpdates];
        }
        else {
            [self reloadData];
        }
	}
    else {
		[self setSectionAtIndex:sectionIndex open:YES];
		
		if (animated) {
            NSArray* indexPathsToInsert = [self indexPathsForRowsInSectionAtIndex:sectionIndex];
            [self insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else {
            [self reloadData];
        }
	}
}

- (void)closeSection:(NSUInteger)sectionIndex animated:(BOOL)animated
{
    [self setSectionAtIndex:sectionIndex open:NO];
	
	if (animated)
    {
        NSArray* indexPathsToDelete = [self indexPathsForRowsInSectionAtIndex:sectionIndex];
        [self deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self reloadData];
    }
}

- (void)toggleSection:(NSUInteger)sectionIndex animated:(BOOL)animated
{
    if (sectionIndex >= [self.sectionsStates count])
    {
		return;
	}
	
	BOOL sectionIsOpen = [[self.sectionsStates objectAtIndex:sectionIndex] boolValue];
	if (sectionIsOpen) {
		[self closeSection:sectionIndex animated:animated];
	}
    else {
		[self openSection:sectionIndex animated:animated];
	}
}

- (BOOL)isOpenSection:(NSUInteger)sectionIndex
{
    if (sectionIndex >= [self.sectionsStates count])
    {
		return NO;
	}
	return [[self.sectionsStates objectAtIndex:sectionIndex] boolValue];
}

- (void)setExclusiveSections:(BOOL)exclusiveSections
{
    _exclusiveSections = exclusiveSections;
    
    if (self.exclusiveSections)
    {
        NSInteger firstSection = NSNotFound;
        
        for (NSUInteger index = 0 ; index < [self.sectionsStates count] ; index++)
        {
            if ([[self.sectionsStates objectAtIndex:index] boolValue])
            {
                if (firstSection == NSNotFound)
                {
                    firstSection = index;
                }
                else
                {
                    [self closeSection:index animated:YES];
                }
            }
        }
    }
}

#pragma mark - DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.collapseDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if ([[self.sectionsStates objectAtIndex:section] boolValue])
    {
		return [self.collapseDataSource tableView:tableView numberOfRowsInSection:section];
	}
	return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger nbSection = [self.collapseDataSource numberOfSectionsInTableView:tableView];
    
	while (nbSection < [self.sectionsStates count])
    {
		[self.sectionsStates removeLastObject];
	}
    
	while (nbSection > [self.sectionsStates count])
    {
		[self.sectionsStates addObject:@NO];
	}
    
	return nbSection;
}

#pragma mark - Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [self.collapseDelegate tableView:tableView viewForHeaderInSection:section];
    
    if (self.shouldHandleHeadersTap)
    {
        NSArray* gestures = view.gestureRecognizers;
        BOOL tapGestureFound = NO;
        for (UIGestureRecognizer* gesture in gestures)
        {
            if ([gesture isKindOfClass:[UITapGestureRecognizer class]])
            {
                tapGestureFound = YES;
                break;
            }
        }
        
        if (!tapGestureFound)
        {
            [view setTag:section];
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        }
    }
    
    return view;
}

#pragma mark - Private methods

- (void)handleTapGesture:(UITapGestureRecognizer*)tap
{
    NSInteger index = tap.view.tag;
    if (index >= 0)
    {
        [self toggleSection:(NSUInteger)index animated:YES];
    }
}

- (NSArray*)indexPathsForRowsInSectionAtIndex:(NSUInteger)sectionIndex
{
	if (sectionIndex >= [self.sectionsStates count])
    {
		return nil;
	}
	
	NSInteger numberOfRows = [self.collapseDataSource tableView:self numberOfRowsInSection:sectionIndex];
	
	NSMutableArray* array = [[NSMutableArray alloc] init];
	
	for (int i = 0 ; i < numberOfRows ; i++)
    {
		[array addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
	}
    
    return array;
}

- (void)setSectionAtIndex:(NSUInteger)sectionIndex open:(BOOL)open
{
	if (sectionIndex >= [self.sectionsStates count])
    {
		return;
	}
	
	[self.sectionsStates replaceObjectAtIndex:sectionIndex withObject:@(open)];
}

- (NSUInteger)openedSection
{
    if (!self.exclusiveSections)
    {
        return NSNotFound;
    }
    
    for (NSUInteger index = 0 ; index < [self.sectionsStates count] ; index++)
    {
        if ([[self.sectionsStates objectAtIndex:index] boolValue])
        {
            return index;
        }
    }
    
    return NSNotFound;
}

@end
