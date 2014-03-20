//
//  CALAgendaCollectionViewDelegate.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/20/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CALAgendaCollectionView;
@protocol CALAgendaCollectionViewDelegate <NSObject>

- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedDate:(NSDate *)selectedDate;

@end
