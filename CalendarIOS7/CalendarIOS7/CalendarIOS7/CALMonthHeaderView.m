//
//  ETIMonthHeaderView.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALMonthHeaderView.h"

@interface CALMonthHeaderView ()
@property (weak, nonatomic) UILabel *day1OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day2OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day3OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day4OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day5OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day6OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day7OfTheWeekLabel;

@property (strong, nonatomic) IBOutletCollection (UILabel) NSMutableArray *weekLabels;
@end

#define CATDayLabelHeight 20.0f

@implementation CALMonthHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.weekLabels = [NSMutableArray arrayWithCapacity:7];
    self.clipsToBounds = YES;
    
    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 15.0f, CGRectGetWidth(self.frame), 30.f)];
    [masterLabel setBackgroundColor:[UIColor clearColor]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.masterLabel = masterLabel;
    [self addSubview:self.masterLabel];
    
    CGFloat yOffset = 44.0f;
    CGFloat oneLabelWidth = CGRectGetWidth(self.frame) / 7;
    CGFloat xOffset = 0.0f;

    UILabel *dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day1OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day1OfTheWeekLabel];
    [self.weekLabels addObject:self.day1OfTheWeekLabel];
    
    xOffset += oneLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day2OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day2OfTheWeekLabel];
    [self.weekLabels addObject:self.day2OfTheWeekLabel];

    xOffset += oneLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day3OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day3OfTheWeekLabel];
    [self.weekLabels addObject:self.day3OfTheWeekLabel];

    xOffset += oneLabelWidth + 5.0f;
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day4OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day4OfTheWeekLabel];
    [self.weekLabels addObject:self.day4OfTheWeekLabel];

    xOffset += oneLabelWidth + 5.0f;
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day5OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day5OfTheWeekLabel];
    [self.weekLabels addObject:self.day5OfTheWeekLabel];

    xOffset += oneLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day6OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day6OfTheWeekLabel];
    [self.weekLabels addObject:self.day6OfTheWeekLabel];

    xOffset += oneLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, oneLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day7OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day7OfTheWeekLabel];
    [self.weekLabels addObject:self.day7OfTheWeekLabel];
}

- (void)updateWithDayNames:(NSArray *)dayNames cellSize:(CGSize)itemSize
{
    CGFloat widthForSpace = CGRectGetWidth(self.bounds) - 7 * itemSize.width;
    CGFloat minimumLineSpacing = widthForSpace / 6.0f;
    
    CGFloat oneLabelWidth = itemSize.width ;
    CGFloat xOffset = 0.0f;
    
    for (int i = 0; i < self.weekLabels.count; i++) {
        UILabel *weekLabel = self.weekLabels[i];
        weekLabel.text = dayNames[i];
        
        CGRect frame = weekLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.masterLabel.frame);
        frame.origin.x = xOffset;
        frame.size.width = oneLabelWidth;
        weekLabel.frame = frame;
        
        xOffset = xOffset + oneLabelWidth + minimumLineSpacing;
    }
}

@end
