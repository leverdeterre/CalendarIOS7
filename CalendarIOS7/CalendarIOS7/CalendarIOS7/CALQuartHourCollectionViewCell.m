//
//  CALQuartHourCollectionViewCell.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/9/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALQuartHourCollectionViewCell.h"
#import "NSDateFormatter+CAT.h"

@interface CALQuartHourCollectionViewCell ()

@property (weak, nonatomic) UIView *selectionView;
@property (weak, nonatomic) UILabel *quartLabel;
@property (weak, nonatomic) UIView *hourView;
@property (weak, nonatomic) UILabel *hourLabel;

@property (assign,nonatomic) CALQuartHourViewRdvState eventTimeState;
@property (strong, nonatomic) NSDate *dateDebut;
@end

@implementation CALQuartHourCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIView *selectionView = [[UIView alloc] initWithFrame:CGRectMake(31.0f, 0.0f, 284.0f, 25.0f)];
    selectionView.backgroundColor = [UIColor clearColor];
    self.selectionView = selectionView;
    [self.contentView addSubview:self.selectionView];
    
    UILabel *quartLabel = [[UILabel alloc] initWithFrame:selectionView.bounds];
    quartLabel.backgroundColor = [UIColor clearColor];
    quartLabel.textAlignment = NSTextAlignmentCenter;
    self.quartLabel = quartLabel;
    [self.selectionView addSubview:quartLabel];

    UIView *hourView = [[UIView alloc] initWithFrame:CGRectMake(31.0f, 0.0f, 284.0f, 25.0f)];
    hourView.backgroundColor = [UIColor clearColor];
    self.hourView = hourView;
    [self.contentView addSubview:hourView];
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.0f, 1.0f, 29.0f, 21.0f)];
    hourLabel.backgroundColor = [UIColor clearColor];
    self.hourLabel = hourLabel;
    [self.contentView addSubview:self.hourLabel];
}

#pragma mark - update 

- (void)updateWithDayStartDate:(NSDate *)dayDate quartState:(CALQuartHourViewRdvState)state hour:(NSInteger)hour patientName:(NSString *)name
{
    _eventTimeState = state;
    //NSDateFormatter *heureFormater = [NSDateFormatter dateFormatterForType:CALDateFormatterType_HH_mm];
    self.selectionView.hidden = NO;
    self.dateDebut = dayDate;
    
    //SelectionView Color
    if (_eventTimeState & CALQuartHourViewRdvStateAlreadyReserved){
        self.selectionView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.75f];
        self.quartLabel.text = name;
        self.quartLabel.hidden = NO;
        self.selectionView.layer.mask = nil;
    }
    else {
        self.selectionView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.75f];
    }
    
    //Custo
    if (_eventTimeState == CALQuartHourViewRdvStateDebutEtFin) {
        [self setMaskTo:self.selectionView byRoundingCorners:UIRectCornerAllCorners];
        //self.quartLabel.text = [NSString stringWithFormat:@"De %@ à %@",[heureFormater stringFromDate:[self.dateDebut toLocalTime]],[heureFormater stringFromDate:[[self.dateDebut toLocalTime] dateByAddingTimeInterval:15*60]]];
    }
    else if (_eventTimeState == CALQuartHourViewRdvStateDebut) {
        [self setMaskTo:self.selectionView byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)];
        //self.quartLabel.text = [NSString stringWithFormat:@"Début à %@",[heureFormater stringFromDate:[self.dateDebut toLocalTime]]];
    }
    else if (_eventTimeState == CALQuartHourViewRdvStateFin) {
        //NSDate *dateFin = [[self.dateDebut toLocalTime] dateByAddingTimeInterval:15*60];
        [self setMaskTo:self.selectionView byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)];
       // self.quartLabel.text = [NSString stringWithFormat:@"Fin à %@",[heureFormater stringFromDate:dateFin]];
    }
    else if(_eventTimeState == CALQuartHourViewRdvStateEntre) {
        self.quartLabel.text = @".";
        self.selectionView.layer.mask = nil;
    }
    else if ( _eventTimeState == CALQuartHourViewRdvStateNone){
        self.selectionView.hidden = YES;
        self.selectionView.layer.mask = nil;
        self.quartLabel.text = @"";
    }
    
    if (hour == NSNotFound) {
        self.hourView.hidden = YES;
        self.hourLabel.hidden = YES;
    }
    else {
        self.hourView.hidden = NO;
        self.hourLabel.hidden = NO;
        self.hourLabel.text = [NSString stringWithFormat:@"%dh", hour];
    }
}


- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds  byRoundingCorners:corners cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

@end
