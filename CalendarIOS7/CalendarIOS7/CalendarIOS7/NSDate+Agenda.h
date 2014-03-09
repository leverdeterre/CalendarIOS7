//
//  NSDate+Agenda.h
//  Patients
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Agenda)

- (NSDate *)firstDayOfTheMonth;

- (NSDate *)lastDayOfTheMonth;
- (NSInteger)weekDay;
- (NSInteger)dayComponents;
- (NSInteger)quartComponents;
- (NSInteger)monthComponents;

+ (NSCalendar *)gregorianCalendar;
+ (NSLocale *)locale;

+ (NSInteger)numberOfMonthFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)fromDate;

- (BOOL)isToday;


- (NSDate *)startingDate;
- (NSDate *)endingDate;

typedef NS_OPTIONS(NSInteger,  NSCalendarUnitCombinary) {
    ETINSCalendarUnitFullDay = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond),
};


@end
