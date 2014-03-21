//
//  CALQuartHourCollectionViewCell.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/9/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALQuartHour.h"

@interface CALQuartHourCollectionViewCell : UICollectionViewCell

- (void)updateWithDayStartDate:(NSDate *)dayDate quartState:(CALQuartHourViewRdvState)state hour:(NSInteger)hour patientName:(NSString *)name;

@end
