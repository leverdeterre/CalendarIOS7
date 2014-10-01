//
//  ETIDayCollectionViewCell.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,  CALDayCollectionViewCellDayType) {
    CALDayCollectionViewCellDayTypeEmpty,
    CALDayCollectionViewCellDayTypeToday,
    CALDayCollectionViewCellDayTypePast,
    CALDayCollectionViewCellDayTypeFutur
};

typedef NS_ENUM(NSInteger,  CALDayCollectionViewCellDayUIStyle) {
    CALDayCollectionViewCellDayUIStyleNone,
    CALDayCollectionViewCellDayUIStyleIOS7,
    CALDayCollectionViewCellDayUIStyleCustom1
};

@interface CALDayCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) CALDayCollectionViewCellDayType type;
@property (assign, nonatomic) CALDayCollectionViewCellDayUIStyle style;

- (void)updateCellWithDate:(NSDate *)date;
- (void)updateCellWithDate:(NSDate *)date andEvents:(NSInteger)nbEvents;

@end
