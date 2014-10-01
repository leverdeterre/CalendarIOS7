//
//  ETIAgendaMonthCollectionViewLayout.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/5/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALCollectionViewFlowLayoutWithStickyHeader.h"

@interface CALAgendaMonthCollectionViewLayout : CALCollectionViewFlowLayoutWithStickyHeader

- (id)initWithWidth:(CGFloat)width;
- (id)initWithWidth:(CGFloat)width itemSize:(CGSize)itemSize;

@end
