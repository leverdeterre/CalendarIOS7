//
//  CALAgendaMonthCollectionView.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/9/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALAgendaCollectionView.h"
#import "CALDayCollectionViewCell.h"
#import "CALQuartHourCollectionViewCell.h"

@implementation CALAgendaCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
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
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self registerClass:[CALDayCollectionViewCell class] forCellWithReuseIdentifier:@"CALDayCollectionViewCell"];
    [self registerNib:[UINib nibWithNibName:@"CALMonthHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CALMonthHeaderView"];
    [self registerNib:[UINib nibWithNibName:@"CALQuartHourCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CALQuartHourCollectionViewCell"];
    [self registerNib:[UINib nibWithNibName:@"CALDayHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CALDayHeaderView"];
    
}


@end
