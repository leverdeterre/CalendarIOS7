//
//  ETIMyAgendaViewController.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/1/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALAgendaViewController.h"

//model
#import "NSDate+ETI.h"
#import "NSDateFormatter+CAT.h"
#import "NSDate+Agenda.h"

//UI
#import "CALMonthHeaderView.h"
#import "CALDayCollectionViewCell.h"
#import "CALAgendaCollectionView.h"
#import "CALQuartHourCollectionViewCell.h"
#import "CALDayHeaderView.h"

//Layout
#import "CALAgendaMonthCollectionViewLayout.h"
#import "CALAgendaDayCollectionViewLayout.h"

@interface CALAgendaViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

//model
@property (strong, nonatomic) NSArray *rdvs;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSMutableDictionary *eventsGroupByDay;

@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateComponents *timeComponents;

@property (strong, nonatomic) NSDate *fromFirstDayMonth;
@property (strong, nonatomic) NSDate *selectedDate;

@end

@implementation CALAgendaViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"Agenda";
    self.calendar = [NSDate gregorianCalendar];
    
    CALAgendaMonthCollectionViewLayout *collectionViewLayout = [CALAgendaMonthCollectionViewLayout new];
    self.calendarCollectionView = [[CALAgendaCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewLayout];
    self.calendarCollectionView.delegate = self;
    [self.view addSubview:self.calendarCollectionView];
    self.calendarCollectionView.dataSource = self;
}

- (void)setFromDate:(NSDate *)fromDate
{
    _fromDate = fromDate;
    self.fromFirstDayMonth = [_fromDate firstDayOfTheMonth];
    if (nil != _toDate) {
        [self.calendarCollectionView reloadData];
    }
}

- (void)setToDate:(NSDate *)toDate
{
    _toDate = toDate;
    if (nil != _fromDate) {
        [self.calendarCollectionView reloadData];
    }
}

- (void)reloadContent
{
    self.fromFirstDayMonth = [_fromDate firstDayOfTheMonth];
    [self.calendarCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if([collectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        return [NSDate numberOfMonthFromDate:self.fromFirstDayMonth toDate:self.toDate];
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([collectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        NSDate *firstDay = [self dateForFirstDayInSection:section];
        NSInteger weekDay = [firstDay weekDay] -1;
        NSInteger items =  weekDay + [NSDate numberOfDaysInMonthForDate:firstDay];
        return items;
    }

    return 24 * 4;
}

- (NSDate *)dateForFirstDayInSection:(NSInteger)section
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = section;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self.fromFirstDayMonth options:0];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        CALDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CALDayCollectionViewCell" forIndexPath:indexPath];
        NSDate *date = [self dateAtIndexPath:indexPath];
        cell.style = self.dayStyle;
        if ( nil == date ) {
            [cell setType:CALDayCollectionViewCellDayTypeEmpty];
        }
        else {
            if ([date isToday]) {
                [cell setType:CALDayCollectionViewCellDayTypeToday];
            }
            else {
                [cell setType:CALDayCollectionViewCellDayTypeFutur];
            }
            
            //NSLog(@"date:%@ events:%d",[self dateAtIndexPath:indexPath],[self eventsAtIndexPath:indexPath].count);
            [cell updateCellWithDate:[self dateAtIndexPath:indexPath] andEvents:[self eventsAtIndexPath:indexPath].count];
        }
        
        return cell;
    }
    else {
        CALQuartHourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CALQuartHourCollectionViewCell" forIndexPath:indexPath];
        
        NSInteger hour = NSNotFound;
        if ((indexPath.row%4) == 0) {
            hour = (indexPath.row/4);
        }
        
        [cell updateWithDayStartDate:nil quartState:CALQuartHourViewRdvStateNone hour:hour patientName:@""];
        return cell;
    }
    
    NSAssert(0, @"UICollectionViewCell is nit??");
	return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.calendarCollectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            CALMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CALMonthHeaderView" forIndexPath:indexPath];
            monthHeader.monthLabel.text = [self monthAtIndexPath:indexPath];
            monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
            return monthHeader;
        }
	}
    else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            CALDayHeaderView *dayHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CALDayHeaderView" forIndexPath:indexPath];
            NSDateFormatter *formater = [NSDateFormatter dateFormatterForType:CALDateFormatterType_EEEE_d_MMMM_yyyy];
            dayHeader.dayLabel.text = [formater stringFromDate:self.selectedDate];
            dayHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
            return dayHeader;
        }
    }
    
    NSAssert(0, @"UICollectionReusableView is nit??");
	return nil;
}

#pragma mark - Private method

- (NSDate *)dateAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *firstDay = [self dateForFirstDayInSection:indexPath.section];
    NSInteger weekDay = [firstDay weekDay];
    NSDate *dateToReturn = nil;
    
    if (indexPath.row < (weekDay-1)) {
        dateToReturn = nil;
    }
    else {
        NSDateComponents *components = [[NSDate gregorianCalendar] components:NSMonthCalendarUnit| NSCalendarUnitDay fromDate:firstDay];
        [components setDay:indexPath.row - (weekDay - 1)];
        [components setMonth:indexPath.section];
        dateToReturn = [[NSDate gregorianCalendar] dateByAddingComponents:components toDate:self.fromFirstDayMonth options:0];
    }
    
    //NSLog(@"Date at indexPath:%@ -> %@", indexPath,dateToReturn);
    return dateToReturn;
}

- (NSString *)monthAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.calendar = self.calendar;
    dateFormatter.dateFormat = [dateFormatter.class dateFormatFromTemplate:@"yyyyLLLL" options:0 locale:[NSDate locale]];
    
    NSDate *date = [self dateForFirstDayInSection:indexPath.section];
    return [dateFormatter stringFromDate:date];
}

- (NSArray *)eventsAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *date = [self dateAtIndexPath:indexPath] ;
    NSDateFormatter *sectionFormater = [NSDateFormatter dateFormatterForType:CALDateFormatterType_dd_MM_yyyy];
    NSArray *events = [self.eventsGroupByDay objectForKey:[sectionFormater stringFromDate:date]];
    return events;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
    self.selectedDate = [self dateAtIndexPath:indexPath];
    [self.agendaDelegate agendaCollectionView:self.calendarCollectionView didSelectItemAtIndexPath:indexPath selectedDate:self.selectedDate];
    
    if ([self.calendarCollectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        [self setDayModeForSelectedIndexPath:indexPath];
    }
}

#pragma mark - UIBArButtonItem

- (void)setDayLeftBarButtonItemWithMonthAtIntexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:[self monthAtIndexPath:indexPath] style:UIBarButtonItemStyleBordered target:self action:@selector(setMonthMode)];
    [[self navigationItem] setLeftBarButtonItem:button animated:YES];
}

- (void)setMonthMode
{
    [[self navigationItem] setLeftBarButtonItem:nil animated:YES];
    
    if ([self.calendarCollectionView.collectionViewLayout isKindOfClass:[CALAgendaDayCollectionViewLayout class]]) {
        CALAgendaMonthCollectionViewLayout *collectionViewLayout = [CALAgendaMonthCollectionViewLayout new];

        __weak CALAgendaViewController* blockSelf = self;
        [self.calendarCollectionView setCollectionViewLayout:collectionViewLayout animated:YES completion:^(BOOL finished) {
            [blockSelf.calendarCollectionView reloadData];
            blockSelf.selectedDate = nil;
        }];
    }
}

- (void)setDayModeForSelectedIndexPath:(NSIndexPath *)indexPath
{
    CALAgendaDayCollectionViewLayout *collectionViewLayout = [CALAgendaDayCollectionViewLayout new];
    __weak CALAgendaViewController* blockSelf = self;
    
    [self.calendarCollectionView setCollectionViewLayout:collectionViewLayout animated:YES completion:^(BOOL finished) {
        [blockSelf.calendarCollectionView reloadData];
        [blockSelf setDayLeftBarButtonItemWithMonthAtIntexPath:indexPath];
        [blockSelf.calendarCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }];
}


@end
