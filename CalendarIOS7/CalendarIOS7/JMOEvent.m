//
//  JMOEvent.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 4/5/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "JMOEvent.h"

@implementation JMOEvent


#pragma mark - CALgendaEvent

- (NSDate *)eventStartDate
{
    return self.startDate;
}

- (NSDate *)eventEndDate
{
    return self.endDate;
}

- (NSString *)eventName
{
    return @"Birthdays";
}

@end
