//
//  CALViewController.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/9/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALViewController.h"
#import "CALAgendaViewController.h"

#import "NSDate+Agenda.h"
#import "NSDate+ETI.h"

@interface CALViewController () <UICollectionViewDelegate>
@property (nonatomic, strong) CALAgendaViewController *agendaVc;
@end

@implementation CALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
}

- (IBAction)showMyCalendar:(id)sender
{
    self.agendaVc = [CALAgendaViewController new];
    self.agendaVc.delegate = self;
    NSDate *now = [[NSDate gregorianCalendar] dateFromComponents:[[NSDate gregorianCalendar]  components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:[NSDate date]]];
    NSDateComponents *components = [NSDateComponents new];
    components.month = -1;
    NSDate *fromDate = [[NSDate gregorianCalendar] dateByAddingComponents:components toDate:now options:0];
    components.month = 6;
    NSDate* toDate = [[NSDate gregorianCalendar] dateByAddingComponents:components toDate:now options:0];
    [self.agendaVc setFromDate:fromDate];
    [self.agendaVc setToDate:toDate];
    self.agendaVc.dayStyle = CALDayCollectionViewCellDayUIStyleIOS7;
    [self.navigationController pushViewController:self.agendaVc animated:YES];
}

- (IBAction)showMyCalendarStyleCustom:(id)sender
{
    self.agendaVc = [CALAgendaViewController new];
    self.agendaVc.delegate = self;
    NSDate *now = [[NSDate gregorianCalendar] dateFromComponents:[[NSDate gregorianCalendar]  components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:[NSDate date]]];
    NSDateComponents *components = [NSDateComponents new];
    components.month = -1;
    NSDate *fromDate = [[NSDate gregorianCalendar] dateByAddingComponents:components toDate:now options:0];
    components.month = 6;
    NSDate* toDate = [[NSDate gregorianCalendar] dateByAddingComponents:components toDate:now options:0];
    [self.agendaVc setFromDate:fromDate];
    [self.agendaVc setToDate:toDate];
    self.agendaVc.dayStyle = CALDayCollectionViewCellDayUIStyleCustom1;
    [self.navigationController pushViewController:self.agendaVc animated:YES];
}

@end
