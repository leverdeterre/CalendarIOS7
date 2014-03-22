//
//  ETIAgendaMonthCollectionViewLayout.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/5/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALAgendaMonthCollectionViewLayout.h"

@interface CALAgendaMonthCollectionViewLayout ()
@end

@implementation CALAgendaMonthCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerReferenceSize = CGSizeMake(320.0f, 64.0f);
        self.itemSize = CGSizeMake(44.0f, 44.0f);
        self.minimumLineSpacing = 2.0f;
        self.minimumInteritemSpacing = 2.0f;
    }
    
    return self;
}

@end
