//
//  NSDate+ETI.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/1/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "NSDate+ETI.h"

@implementation NSDate (ETI)

- (NSDate *)dateByAddingYears:(NSInteger)numberOfYears
{
    NSDate *todaysDate = self;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:numberOfYears];
    NSDate *targetDate = [gregorian dateByAddingComponents:dateComponents toDate:todaysDate  options:0];
    return targetDate;
}


- (NSDate *)dateByAddingDays:(NSInteger)numberOfDays
{
    return [self dateByAddingTimeInterval:60*60*24*numberOfDays];
}

-(NSDate *) toLocalTime
{
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

-(NSDate *) toGlobalTime
{
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}



@end
