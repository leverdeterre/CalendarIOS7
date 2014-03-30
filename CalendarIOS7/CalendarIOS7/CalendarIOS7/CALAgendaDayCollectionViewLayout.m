//
//  CALAgendaDayCollectionViewLayout.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/9/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALAgendaDayCollectionViewLayout.h"

@implementation CALAgendaDayCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.headerReferenceSize = CGSizeMake(320.0f, 30.0f);
        self.itemSize = CGSizeMake(320.0f, 25.0f);
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
    }
    
    return self;
}

@end
