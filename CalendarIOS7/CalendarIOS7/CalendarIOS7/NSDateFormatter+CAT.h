//
//  NSDateFormatter+CAT.h
//  catech
//
//  Created by Mickael Laloum on 20/01/2014.
//
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
