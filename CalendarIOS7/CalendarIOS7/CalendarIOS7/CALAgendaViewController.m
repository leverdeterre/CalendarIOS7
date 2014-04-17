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
#import "CALDay.h"
#import "CALQuartHour.h"
#import "CALAgendaEvent.h"

//UI
#import "CALMonthHeaderView.h"
#import "CALDayCollectionViewCell.h"
#import "CALAgendaCollectionView.h"
#import "CALQuartHourCollectionViewCell.h"
#import "CALDayHeaderView.h"

//Layout
#import "CALAgendaMonthCollectionViewLayout.h"
#import "CALAgendaDayCollectionViewLayout.h"

#import "JMOLogMacro.h"

@interface CALAgendaViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

//model
@property (strong, nonatomic) NSArray *rdvs;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSMutableDictionary *eventsGroupByDay;

@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateComponents *timeComponents;

@property (strong, nonatomic) NSDate *fromFirstDayMonth;
@property (strong, nonatomic) CALAgendaMonthCollectionViewLayout *collectionMonthLayout;
//Quarts selection
@property (strong, nonatomic) CALDay *dayStructured;

@end

@implementation CALAgendaViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"Agenda";
    self.calendar = [NSDate gregorianCalendar];
    
    self.collectionMonthLayout = [CALAgendaMonthCollectionViewLayout new];
    self.collectionMonthLayout.scrollDirection = self.calendarScrollDirection;
    self.calendarCollectionView = [[CALAgendaCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionMonthLayout];
    self.calendarCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    self.calendarCollectionView.delegate = self;
    [self.view addSubview:self.calendarCollectionView];
    self.calendarCollectionView.dataSource = self;
    self.dayStructured = [CALDay new];
    [self reloadContent];
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
    [self updateEventGroupByDays];
    [self.calendarCollectionView reloadData];
}

- (void)updateEventGroupByDays
{
    self.eventsGroupByDay = [NSMutableDictionary new];
    for (id <CALgendaEvent> obj in self.events) {
        NSDate *startDate = [obj eventStartDate];
        NSDateFormatter *sectionFormater = [NSDateFormatter dateFormatterForType:CALDateFormatterType_dd_MM_yyyy];
        NSMutableArray *events = [self.eventsGroupByDay objectForKey:[sectionFormater stringFromDate:startDate]];
        if (events == nil) {
            events = [NSMutableArray new];
        }
        [events addObject:obj];
        [self.eventsGroupByDay setObject:events forKey:[sectionFormater stringFromDate:startDate]];
    }
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
        
        NSArray *events = [self eventsAtIndexPath:indexPath];
        if (events.count > 0) {
            JMOLog(@"");
        }
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
        
        CALQuartHour *qh = self.dayStructured.quarts[indexPath.row];
        [cell updateWithDayStartDate:nil quartState:qh.state hour:hour patientName:@""];
        return cell;
    }
    
    NSAssert(0, @"UICollectionViewCell is nit??");
	return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.calendarCollectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            CALMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CALMonthHeaderView" forIndexPath:indexPath];
            monthHeader.masterLabel.text = [self monthAtIndexPath:indexPath];
            [monthHeader updateWithDayNames:[NSDate weekdaySymbols]];
            monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
            return monthHeader;
        }
	}
    else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            CALDayHeaderView *dayHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CALDayHeaderView" forIndexPath:indexPath];
            NSDateFormatter *formater = [NSDateFormatter dateFormatterForType:CALDateFormatterType_EEEE_d_MMMM_yyyy];
            dayHeader.dayLabel.text = [formater stringFromDate:self.dayStructured.date];
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
    /*
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.calendar = self.calendar;
    dateFormatter.dateFormat = [dateFormatter.class dateFormatFromTemplate:@"yyyyLLLL" options:0 locale:[NSDate locale]];
    
    NSDate *date = [self dateForFirstDayInSection:indexPath.section];
    return [dateFormatter stringFromDate:date];
     */
    
    NSDate *date = [self dateForFirstDayInSection:indexPath.section];
    NSDateComponents *components = [[NSDate gregorianCalendar] components:NSMonthCalendarUnit fromDate:date];
    return [NSDate monthSymbolAtIndex:components.month];
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
    JMOLog(@"%s",__FUNCTION__);
    if ([self.calendarCollectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        self.dayStructured.date = [self dateAtIndexPath:indexPath];
    }
    
    if ([self.agendaDelegate respondsToSelector:@selector(agendaCollectionView:didSelectItemAtIndexPath:selectedDate:)]) {
        [self.agendaDelegate agendaCollectionView:self.calendarCollectionView didSelectItemAtIndexPath:indexPath selectedDate:self.dayStructured.date];
    }
    
    if ([self.calendarCollectionView.collectionViewLayout isKindOfClass:[CALAgendaMonthCollectionViewLayout class]]) {
        [self setDayModeForSelectedIndexPath:indexPath];
    }
    else {
        BOOL canSelect = YES;
        if ([self.agendaDelegate respondsToSelector:@selector(agendaCollectionView:canSelectDate:)]) {
            canSelect = [self.agendaDelegate agendaCollectionView:self.calendarCollectionView canSelectDate:[self.dayStructured.date dateByAddingTimeInterval:indexPath.row*15*60]];
        }
        if (canSelect == YES) {
            [self collectionView:self.calendarCollectionView didSelecQuartAtIndexPath:indexPath];
            if ([self.agendaDelegate respondsToSelector:@selector(agendaCollectionView:didSelectItemAtIndexPath:startDate:endDate:)]) {
                [self.agendaDelegate agendaCollectionView:self.calendarCollectionView didSelectItemAtIndexPath:indexPath startDate:[self.dayStructured fromDate] endDate:[self.dayStructured toDate]];
            }
        }
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
        __weak CALAgendaViewController* blockSelf = self;
        [self.calendarCollectionView setCollectionViewLayout:self.collectionMonthLayout animated:YES completion:^(BOOL finished) {
            [blockSelf.calendarCollectionView reloadData];
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

#pragma mark - Quarts selction

- (void)collectionView:(UICollectionView *)collectionView didSelecQuartAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dayStructured numberOfSelectedQuarts] == 0) {
        [self.dayStructured selectQuartsFrom:indexPath.row to:indexPath.row];
        [self.calendarCollectionView reloadData];
    }
    else if ([self.dayStructured numberOfSelectedQuarts] == 1) {
        //select from 1 to 2
        NSInteger last = indexPath.row;
        NSInteger first = [self.dayStructured firstSelectedQuart];
        
        if (first == last) {
            CALQuartHour *quart = self.dayStructured.quarts[indexPath.row];
            quart.state = CALQuartHourViewRdvStateNone;
            //[self.calendarCollectionView reloadItemsAtIndexPaths:@[indexPath]];
            [self.calendarCollectionView reloadData];
            return;
        }
        
        if (last < first) {
            NSInteger temp = first;
            first = last;
            last = temp;
        }
        
        [self.dayStructured selectQuartsFrom:first to:last];
        //[self.calendarCollectionView reloadItemsAtIndexPaths:[self indexPathsFrom:first to:last]];
        [self.calendarCollectionView reloadData];

    }
    else {
        //select from 1 to 2
        NSInteger newSelectedIndex = indexPath.row;
        NSInteger previousFirst = [self.dayStructured firstSelectedQuart];
        NSInteger previousLast = [self.dayStructured lastSelectedQuart];
        
        NSInteger newFirst = previousFirst;
        NSInteger newLast = previousLast;
        if (newSelectedIndex < previousFirst) {
            newFirst = newSelectedIndex;
        }
        else if (newSelectedIndex > newLast) {
            newLast = newSelectedIndex;
        }
        else if ((newSelectedIndex - previousFirst) < (previousLast - newSelectedIndex)) {
            if (previousFirst == newSelectedIndex) {
                newFirst++;
            }
            else {
                newFirst = newSelectedIndex;
            }
        }
        else if ((newSelectedIndex - previousFirst) > (previousLast - newSelectedIndex)) {
            if (previousLast == newSelectedIndex ) {
                newLast--;
            }
            else {
                newLast = newSelectedIndex;
            }
        }
        
        [self.dayStructured selectQuartsFrom:newFirst to:newLast];
        //[self.calendarCollectionView reloadItemsAtIndexPaths:[self indexPathsFrom:newFirst to:newLast]];
        [self.calendarCollectionView reloadData];

    }
}

- (NSArray *)indexPathsFrom:(NSInteger)from to:(NSInteger)to
{
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (int i = from; i <= to; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    return indexPaths;
}

@end
