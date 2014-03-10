//
//  NSDateFormatter+CAT.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, CALDateFormatterType) {
    CALDateFormatterType_dd_MM_yyyy,
    CALDateFormatterType_HH_mm,
    CALDateFormatterType_EEEE_d_MMMM_yyyy
};

@interface NSDateFormatter (CAT)

+ (instancetype) dateFormatterForType:(CALDateFormatterType)type;

@end
