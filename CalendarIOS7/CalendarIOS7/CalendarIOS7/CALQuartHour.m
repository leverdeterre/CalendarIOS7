//
//  CALQuartHour.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/21/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALQuartHour.h"

@implementation CALQuartHour

- (id)init
{
    self = [super init];
    if (self) {
        _state = CALQuartHourViewRdvStateNone;
    }
    
    return self;
}

- (BOOL)isSelected
{
    if (self.state & CALQuartHourViewRdvStateDebut ||
        self.state & CALQuartHourViewRdvStateEntre ||
        self.state & CALQuartHourViewRdvStateFin)  {
        return YES;
    }
    
    return NO;
}


@end

