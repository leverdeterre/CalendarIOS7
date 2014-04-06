//
//  JMOEvent.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 4/5/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CALAgendaEvent.h"

@interface JMOEvent : NSObject <CALgendaEvent>

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
