//
//  ETIMyAgendaViewController.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/1/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALDayCollectionViewCell.h"
#import "CALAgendaCollectionViewDelegate.h"

@interface CALAgendaViewController : UIViewController

@property (strong, nonatomic) IBOutlet CALAgendaCollectionView *calendarCollectionView;

@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) NSArray *events;
@property (weak, nonatomic) id <CALAgendaCollectionViewDelegate> agendaDelegate;
@property (assign, nonatomic) CALDayCollectionViewCellDayUIStyle dayStyle;
@property (assign, nonatomic) UICollectionViewScrollDirection calendarScrollDirection;

- (void)reloadContent;

@end
