//
//  ETIDayCollectionViewCell.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALDayCollectionViewCell.h"
#import "NSDate+Agenda.h"

@interface CALDayCollectionViewCell()
@property (strong, nonatomic) UILabel *dayLabel;
@property (strong, nonatomic) UILabel *nbEventsLabel;

//Style
@property (strong, nonatomic) CALayer *separatorLayer;
@property (strong, nonatomic) UIColor *contentViewColor;

//today
@property (strong, nonatomic) CALayer *todayLayer;

//events
@property (strong, nonatomic) CALayer *eventsLayer;
@end

@implementation CALDayCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self removeEventsLayer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _style = CALDayCollectionViewCellDayUIStyleNone;
        
        _dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
		_dayLabel.textAlignment = NSTextAlignmentCenter;
        [_dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];

        _dayLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_dayLabel];

        _nbEventsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 29.0f, 44.0f, 15.0f)];
		_nbEventsLabel.textAlignment = NSTextAlignmentRight;
		_nbEventsLabel.font = [UIFont systemFontOfSize:12.0f];
        _nbEventsLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:_nbEventsLabel];
        
    }
    return self;
}

#pragma mark - Overided setter 

- (void)setStyle:(CALDayCollectionViewCellDayUIStyle)style
{
    if (_style == style) {
        return;
    }
    
    if (style == CALDayCollectionViewCellDayUIStyleIOS7) {
        _separatorLayer = [[CALayer alloc] init];
        [_separatorLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
        [_separatorLayer setFrame:CGRectMake(-2.0f, 0.0f, 46.0f, 1.0f)];
        [self.layer addSublayer:_separatorLayer];
        self.contentViewColor = [UIColor clearColor];
        self.clipsToBounds = NO;
    }
    else {
        [_separatorLayer removeFromSuperlayer];
        _separatorLayer = nil;
        self.clipsToBounds = YES;
        self.contentViewColor = [[UIColor blueColor] colorWithAlphaComponent:0.05f];
    }
    
    _style = style;
}


#pragma mark - Updates

- (void)updateCellWithDate:(NSDate *)date
{
    self.dayLabel.text = [NSString stringWithFormat:@"%d", [date dayComponents]];
}

- (void)updateCellWithDate:(NSDate *)date andEvents:(NSInteger)nbEvents
{
    [self updateCellWithDate:date];
    if (nbEvents > 0) {
        //self.nbEventsLabel.text = [NSString stringWithFormat:@"%d", nbEvents];
    } else {
        self.nbEventsLabel.text = @"";
    }
    
    [self removeEventsLayer];
    if (nbEvents > 0) {
        [self addEventsLayer];
    }
}

- (void)setType:(CALDayCollectionViewCellDayType)type
{
    _type = type;

    self.backgroundColor = [UIColor clearColor];
    [self removeTodayLayer];
    [self setUserInteractionEnabled:YES];
    self.dayLabel.textColor = [UIColor blackColor];

    switch (type) {
        case CALDayCollectionViewCellDayTypeEmpty:
            self.dayLabel.text = @"";
            [self.contentView setBackgroundColor:[UIColor clearColor]];
            [self.contentView.layer setCornerRadius:0.0f];
            [self.separatorLayer setBackgroundColor:[UIColor clearColor].CGColor];
            [self setUserInteractionEnabled:NO];
            break;
            
        case CALDayCollectionViewCellDayTypeToday:
            self.dayLabel.text = @"";
            self.dayLabel.textColor = [UIColor whiteColor];
            self.todayLayer = [[CALayer alloc] init];
            [self.todayLayer setFrame:CGRectMake(6.0f, 6.0f, 32.0f, 32.0f)];
            [self.todayLayer setBackgroundColor:[UIColor redColor].CGColor];
            [self.todayLayer setCornerRadius:16.0f];
            [self.contentView.layer addSublayer:self.todayLayer];
            [self.contentView setBackgroundColor:self.contentViewColor];
            [self.separatorLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
            break;
     
        case CALDayCollectionViewCellDayTypePast:
        case CALDayCollectionViewCellDayTypeFutur:
            self.dayLabel.text = @"";
            [self.contentView setBackgroundColor:self.contentViewColor];
            [self.contentView.layer setCornerRadius:0.0f];
            [self.separatorLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
            break;
            
        default:
            break;
    }
}

- (void)removeTodayLayer
{
    if ( nil != self.todayLayer) {
        [self.todayLayer removeFromSuperlayer];
        self.todayLayer = nil;
    }
}

#pragma mark - eventLayer

- (void)addEventsLayer
{
    // Set up the shape of the circle
    int radius = 3;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.bounds)-radius,
                                  CGRectGetMaxY(self.bounds)-radius - 5.0f);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor grayColor].CGColor;
    circle.strokeColor = [UIColor grayColor].CGColor;
    circle.lineWidth = 1;
    
    self.eventsLayer = circle;
    
    // Add to parent layer
    [self.layer addSublayer:self.eventsLayer];
}

- (void)removeEventsLayer
{
    [self.eventsLayer removeFromSuperlayer];
    self.eventsLayer = nil;
}

@end
