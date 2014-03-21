//
//  CALQuartHour.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/21/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger,  CALQuartHourViewRdvState) {
    CALQuartHourViewRdvStateNone = 1 << 0,
    CALQuartHourViewRdvStateDebut = 1 << 1,
    CALQuartHourViewRdvStateEntre = 1 << 2,
    CALQuartHourViewRdvStateFin = 1 << 3,
    CALQuartHourViewRdvStateAlreadyReserved = 1 << 4,
    CALQuartHourViewRdvStateDebutEtFin = (CALQuartHourViewRdvStateDebut | CALQuartHourViewRdvStateFin)
};

@interface CALQuartHour : NSObject

@property (assign, nonatomic) CALQuartHourViewRdvState state;

- (BOOL)isSelected;

@end