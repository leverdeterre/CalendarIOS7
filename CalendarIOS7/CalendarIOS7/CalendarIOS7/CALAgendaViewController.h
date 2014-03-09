//
//  ETIMyAgendaViewController.h
//  Patients
//
//  Created by Jerome Morissard on 3/1/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALDayCollectionViewCell.h"

@interface CALAgendaViewController : UIViewController

@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (assign, nonatomic) CALDayCollectionViewCellDayUIStyle dayStyle;

@property (weak, nonatomic) id <UICollectionViewDelegate> delegate;

- (void)reloadContent;

@end
