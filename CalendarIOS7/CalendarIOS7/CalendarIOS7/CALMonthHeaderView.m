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
@end


#define CATDayLabelWidth  40.0f
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
    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 15.0f, 300.0f, 30.f)];
    [masterLabel setBackgroundColor:[UIColor clearColor]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.masterLabel = masterLabel;
    [self addSubview:self.masterLabel];
    
    CGFloat xOffset = 5.0f;
    CGFloat yOffset = 44.0f;

    UILabel *dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day1OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day1OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day2OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day2OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day3OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day3OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day4OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day4OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day5OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day5OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day6OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day6OfTheWeekLabel];

    xOffset += CATDayLabelWidth + 5.0f;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, CATDayLabelWidth, CATDayLabelHeight)];
    dayOfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    self.day7OfTheWeekLabel = dayOfTheWeekLabel;
    [self addSubview:self.day7OfTheWeekLabel];
}

- (void)updateWithDayNames:(NSArray *)dayNames
{
    for (int i = 0 ; i < dayNames.count; i++) {
        switch (i) {
            case 0:
                self.day1OfTheWeekLabel.text = dayNames[i];
                break;

            case 1:
                self.day2OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 2:
                self.day3OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 3:
                self.day4OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 4:
                self.day5OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 5:
                self.day6OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 6:
                self.day7OfTheWeekLabel.text = dayNames[i];
                break;
                
            default:
                break;
        }
    }
}

@end
