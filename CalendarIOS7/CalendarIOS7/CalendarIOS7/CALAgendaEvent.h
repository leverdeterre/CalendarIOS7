//
//  CALgendaEvent.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/4/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CALgendaEvent <NSObject>

- (NSDate *)eventStartDate;
- (NSDate *)eventEndDate;
- (NSString *)eventName;

@end
