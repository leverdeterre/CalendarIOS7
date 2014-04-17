//
//  NSDate+Agenda.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "NSDate+Agenda.h"
#import <objc/runtime.h>

const char * const JmoCalendarStoreKey = "jmo.calendar";
const char * const JmoLocaleStoreKey = "jmo.locale";

@implementation NSDate (Agenda)

#pragma mark - Getter and Setter

+ (void)setGregorianCalendar:(NSCalendar *)gregorianCalendar
{
    objc_setAssociatedObject(self, JmoCalendarStoreKey, gregorianCalendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSCalendar *)gregorianCalendar
{
    NSCalendar* cal = objc_getAssociatedObject(self, JmoCalendarStoreKey);
    if (nil == cal) {
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [cal setLocale:[self locale]];
        [self setGregorianCalendar:cal];
        
    }
    return cal;
}

+ (void)setLocal:(NSLocale *)locale
{
    objc_setAssociatedObject(self, JmoLocaleStoreKey, locale, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSLocale *)locale
{
    NSLocale *locale  = objc_getAssociatedObject(self, JmoLocaleStoreKey);
    if (nil == locale) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        [self setLocal:locale];
    }
    return locale;
}

#pragma mark -

- (NSDate *)firstDayOfTheMonth
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comps];
    return firstDayOfMonthDate;
}

- (NSDate *)lastDayOfTheMonth
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents* comps = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self];
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *lastDayOfMonthDate = [gregorian dateFromComponents:comps];
    return lastDayOfMonthDate;
}

+ (NSInteger)numberOfMonthFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *gregorian = [self gregorianCalendar];
    return [gregorian components:NSMonthCalendarUnit fromDate:fromDate toDate:toDate options:0].month+1;
}

+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)fromDate
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:fromDate];
    return range.length;
}

- (NSInteger)weekDay
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    int weekday = [comps weekday];
    return weekday ;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *otherDay = [calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return YES;
    }
    return NO;
}

- (NSInteger)quartComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return comps.hour*4+(comps.minute/15);
}

- (NSInteger)dayComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components: NSDayCalendarUnit fromDate:self];
    return comps.day;
}


- (NSInteger)monthComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components: NSDayCalendarUnit fromDate:self];
    return comps.day;
}

- (NSDate *)startingDate
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate gregorianCalendar] dateFromComponents:components];
}

- (NSDate *)endingDate
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSDate gregorianCalendar] dateFromComponents:components];
}

+ (NSArray *)weekdaySymbols
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableArray *upper = [NSMutableArray new];
    for (NSString *day in [dateFormatter shortWeekdaySymbols]) {
        [upper addObject:day.uppercaseString];
    }
    return  upper;
}

+ (NSString *)monthSymbolAtIndex:(NSInteger)index
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *months = [dateFormatter monthSymbols];
    return months[index - 1];
}

@end
