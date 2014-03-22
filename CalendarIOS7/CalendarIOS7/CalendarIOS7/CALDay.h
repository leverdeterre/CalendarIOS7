//
//  CALDay.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/21/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CALDay : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSArray *quarts;  //CALQuartHour

- (NSInteger)numberQuarts;
- (NSInteger)numberOfSelectedQuarts;
- (NSInteger)firstSelectedQuart;
- (NSInteger)lastSelectedQuart;

- (void)selectQuartsFrom:(NSInteger)from to:(NSInteger)to;
- (void)resetQuartsStates;

- (NSDate *)fromDate;
- (NSDate *)toDate;

@end
