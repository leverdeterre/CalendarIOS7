//
//  CALDay.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/21/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALDay.h"
#import "CALQuartHour.h"
#import "JMOLogMacro.h"

@implementation CALDay

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *quartsM = [NSMutableArray new];
        for (int i = 0; i < 24 * 4; i++) {
            [quartsM addObject:[CALQuartHour new]];
        }
        _quarts = quartsM;
    }
    
    return self;
}

- (NSInteger)numberQuarts
{
    return self.quarts.count;
}

- (NSInteger)numberOfSelectedQuarts
{
    NSInteger num = 0;
    for (int i = 0; i < self.quarts.count ; i++) {
        CALQuartHour *quart = self.quarts[i];
        if ([quart isSelected]) {
            num++;
        }
    }
    return num;
}

- (NSInteger)firstSelectedQuart
{
    for (int i = 0; i < self.quarts.count ; i++) {
        CALQuartHour *quart = self.quarts[i];
        if ([quart isSelected]) {
            return i;
        }
    }
    return NSNotFound;
}

- (NSInteger)lastSelectedQuart
{
    for (int i =  self.quarts.count-1; i >= 0 ; i--) {
        CALQuartHour *quart = self.quarts[i];
        if ([quart isSelected]) {
            return i;
        }
    }
    return NSNotFound;
}

- (void)selectQuartsFrom:(NSInteger)from to:(NSInteger)to
{
    JMOLog(@"select from %d to %d", from, to);
    [self resetQuartsStates];
    CALQuartHourViewRdvState state = CALQuartHourViewRdvStateDebut;
    for (int i = from; i <= to; i++) {
        if (i == to && i == from) {
            state = CALQuartHourViewRdvStateFin | CALQuartHourViewRdvStateDebut;
        }
        else if (i == to) {
            state = CALQuartHourViewRdvStateFin;
        }
        else if (i == from){
            state = CALQuartHourViewRdvStateDebut;
        }
        else {
            state = CALQuartHourViewRdvStateEntre;
        }
        
        CALQuartHour *quart = self.quarts[i];
        quart.state = state;
    }
    
}

- (void)resetQuartsStates
{
    for (int i = 0; i < self.quarts.count; i++) {
        CALQuartHour *quart = self.quarts[i];
        quart.state = CALQuartHourViewRdvStateNone;
    }
}

- (NSDate *)fromDate
{
    NSInteger firstSelectedQuart = [self firstSelectedQuart];
    if (firstSelectedQuart == NSNotFound) {
        return nil;
    }
    
    return [self.date dateByAddingTimeInterval:15*60*firstSelectedQuart];
}

- (NSDate *)toDate
{
    NSInteger lastSelectedQuart = [self lastSelectedQuart];
    if (lastSelectedQuart == NSNotFound) {
        return nil;
    }
    
    return [self.date dateByAddingTimeInterval:15*60*(lastSelectedQuart+1)];
}

@end
