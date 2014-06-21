//
//  CALAgendaLinearMonthCollectionViewLayout.m
//  CalendarIOS7
//
//  Created by jerome morissard on 21/06/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALAgendaLinearMonthCollectionViewLayout.h"
#import "JMOLogMacro.h"

static NSString * const CALAgendaMonthCollectionViewLayoutCell = @"CALAgendaMonthCollectionViewLayoutCell";

@interface CALAgendaLinearMonthCollectionViewLayout ()
@property (nonatomic, strong) NSDictionary *layoutInfo;
@end

@implementation CALAgendaLinearMonthCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        //self.headerReferenceSize = CGSizeMake(320.0f, 64.0f);
        self.itemSize = CGSizeMake(44.0f, 44.0f);
        self.minimumLineSpacing = 2.0f;
        self.minimumInteritemSpacing = 2.0f;
    }
    
    return self;
}

#pragma mark - Layout

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    //NSMutableDictionary *headerLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath;
    CGRect previousRect = CGRectZero;
    NSIndexPath *previousIndexPath;
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        //UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        //itemAttributes.frame = [self frameForHeaderAtSection:indexPath.section previousRect:previousRect previousIndexPath:previousIndexPath];
        //headerLayoutInfo[indexPath] = itemAttributes;
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForItemAtIndexPath:indexPath previousRect:previousRect previousIndexPath:previousIndexPath];
            previousRect = itemAttributes.frame;
            JMOLog(@"indexPath(%@) -> %@",indexPath, NSStringFromCGRect(previousRect));
            cellLayoutInfo[indexPath] = itemAttributes;
            previousIndexPath = indexPath;
        }
    }
    
    newLayoutInfo[CALAgendaMonthCollectionViewLayoutCell] = cellLayoutInfo;
    //newLayoutInfo[CALAgendaMonthCollectionViewLayoutHeader] = headerLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (CGSize)collectionViewContentSize
{
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //compute the worst case
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:[self.collectionView numberOfItemsInSection:[self.collectionView numberOfSections]-1]-1 inSection:[self.collectionView numberOfSections]-1];
        UICollectionViewLayoutAttributes *itemAttributes = self.layoutInfo[CALAgendaMonthCollectionViewLayoutCell][lastIndexPath];
        JMOLog(@"COntent size -> %@", NSStringFromCGSize(CGSizeMake(320.0f, itemAttributes.frame.origin.y + itemAttributes.frame.size.height)));
        return CGSizeMake(320.0f, itemAttributes.frame.origin.y + itemAttributes.frame.size.height);
    }
    else {
        //compute the worst case
        JMOLog(@"TODO try to implement this layout horizontaly");
        return CGSizeZero;
    }
}

#pragma mark - Cells Layout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[CALAgendaMonthCollectionViewLayoutCell][indexPath];
}


- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath previousRect:(CGRect)previousRect previousIndexPath:(NSIndexPath*)previousIndexPath
{
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        if (CGRectEqualToRect(CGRectZero, previousRect)) {
            return CGRectMake(0.0f, self.headerReferenceSize.height + self.minimumLineSpacing, self.itemSize.width, self.itemSize.height);
        }
        else {
            CGRect theoricalRect = previousRect;
            theoricalRect.origin.x = theoricalRect.origin.x + self.minimumInteritemSpacing + self.itemSize.width;
            if ((theoricalRect.origin.x + self.itemSize.width) > self.collectionView.frame.size.width) {
                theoricalRect.origin.x = 0.0f;
                theoricalRect.origin.y = theoricalRect.origin.y + self.minimumLineSpacing + self.itemSize.height;
            }
            return theoricalRect;
        }
    }
    else {
        JMOLog(@"TODO try to implement this layout horizontaly");
        return CGRectZero;
    }
    
    return CGRectZero;
}

/*
#pragma mark - Headers Layout

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[CALAgendaMonthCollectionViewLayoutHeader][indexPath];
}

- (CGRect)frameForHeaderAtSection:(NSInteger)section previousRect:(CGRect)previousRect previousIndexPath:(NSIndexPath*)previousIndexPath
{
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        if (CGRectEqualToRect(CGRectZero, previousRect)) {
            return CGRectMake(0.0f, 0.0f, self.headerReferenceSize.width, self.headerReferenceSize.height);
        }
        else {
            CGRect theoricalRect = previousRect;
            theoricalRect.origin.x = 0.0f;
            theoricalRect.origin.y = theoricalRect.origin.y + self.itemSize.height + self.minimumLineSpacing;
            theoricalRect.size.width = self.headerReferenceSize.width;
            theoricalRect.size.height = self.headerReferenceSize.height;
            return theoricalRect;
        }
    }
    else {
        if (CGRectEqualToRect(CGRectZero, previousRect)) {
            return CGRectMake(0.0f, 0.0f, self.headerReferenceSize.width, self.headerReferenceSize.height);
        }
        else {
            CGRect theoricalRect = previousRect;
            theoricalRect.origin.x = section * self.headerReferenceSize.width;
            theoricalRect.origin.y = 0.0f;
            theoricalRect.size.width = self.headerReferenceSize.width;
            theoricalRect.size.height = self.headerReferenceSize.height;
            return theoricalRect;
        }
    }
    
    return CGRectZero;
}
*/

@end
