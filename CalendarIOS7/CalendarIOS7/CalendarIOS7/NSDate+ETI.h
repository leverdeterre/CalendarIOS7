//
//  NSDate+ETI.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/1/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ETI)

- (NSDate *)dateByAddingYears:(NSInteger)numberOfYears;
- (NSDate *)dateByAddingDays:(NSInteger)numberOfDays;
- (NSDate *)toGlobalTime;
- (NSDate *)toLocalTime;

@end
