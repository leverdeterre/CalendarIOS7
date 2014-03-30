Calendar iOS
==================

Calendar iOS is a very simple calendar/date picker component for your iOS apps based on UICollectionView and 2 layouts.

Day cells styles
---------------------------------------------------
![Image](./Screenshots/Calendar.png)


Supported iOS & SDK Versions
---------------------------------------------------

* Earliest supported deployment target - iOS 6.0

Creating a CalendarViewController
---------------------------------------------------


```objc
    CALAgendaViewController *agendaVc = [CALAgendaViewController new];
    agendaVc.agendaDelegate = self;
    [agendaVc setFromDate:fromDate];
    [agendaVc setToDate:toDate];
    #Select cell style
	agendaVc.dayStyle = CALDayCollectionViewCellDayUIStyleIOS7;
```

Delegation : CALAgendaCollectionViewDelegate
---------------------------------------------------


```objc
- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedDate:(NSDate *)selectedDate;
```


```objc
- (BOOL)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView canSelectDate:(NSDate *)selectedDate;
```


```objc
- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath startDate:(NSDate *)startDate endDate:(NSDate*)endDate;
```

Other protocols : CALgendaEvent
---------------------------------------------------
To be implemented by your Event objects to be presented in the calendar. (in progress)

TODOS
---------------------------------------------------

- Improve genericity and customization of cells,
- Manage events / days
- Hours selection is a draft version .. so i'have to finish it :)




