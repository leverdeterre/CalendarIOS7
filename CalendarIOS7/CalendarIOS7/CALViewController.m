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
#import "CALAgenda.h"

@interface CALViewController () <UICollectionViewDelegate, CALAgendaCollectionViewDelegate>
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
    self.agendaVc.agendaDelegate = self;
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
    self.agendaVc.agendaDelegate = self;
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


#pragma mark - CALAgendaCollectionViewDelegate

- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedDate:(NSDate *)selectedDate
{
    NSLog(@"%s %@", __FUNCTION__, selectedDate);
}

- (BOOL)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView canSelectDate:(NSDate *)selectedDate
{
    return YES;
}

- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSLog(@"%s %@ -> %@", __FUNCTION__,startDate, endDate);
    if (nil != startDate && nil != endDate) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Continuer" style:UIBarButtonItemStyleBordered target:self action:nil];
        [[self.agendaVc navigationItem] setRightBarButtonItem:button animated:YES];
    }
    else {
        [[self.agendaVc navigationItem] setRightBarButtonItem:nil animated:YES];
    }
}


@end
