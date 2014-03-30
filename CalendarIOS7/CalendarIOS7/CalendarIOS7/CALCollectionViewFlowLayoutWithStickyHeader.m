//
//  CALCollectionViewFlowLayoutWithStickyHeader.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/22/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "CALCollectionViewFlowLayoutWithStickyHeader.h"

@implementation CALCollectionViewFlowLayoutWithStickyHeader

///Sticky section header View
- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *answer = /*[*/[super layoutAttributesForElementsInRect:rect]; /*mutableCopy];*/
    UICollectionView * const cv = self.collectionView;
    CGPoint const contentOffset = cv.contentOffset;
    
    /*
     NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
     for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
     if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
     [missingSections addIndex:layoutAttributes.indexPath.section];
     }
     }
     for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
     if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
     [missingSections removeIndex:layoutAttributes.indexPath.section];
     }
     }
     
     [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
     NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
     UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
     [answer addObject:layoutAttributes];
     }];
     */
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            NSInteger section = layoutAttributes.indexPath.section;
            NSInteger numberOfItemsInSection = [cv numberOfItemsInSection:section];
            
            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
            
            UICollectionViewLayoutAttributes *firstObjectAttrs;
            UICollectionViewLayoutAttributes *lastObjectAttrs;
            
            if (numberOfItemsInSection > 0) {
                firstObjectAttrs = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
                lastObjectAttrs = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];
            } else {
                firstObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                        atIndexPath:firstObjectIndexPath];
                lastObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                       atIndexPath:lastObjectIndexPath];
            }
            
            CGFloat headerHeight = CGRectGetHeight(layoutAttributes.frame);
            CGPoint origin = layoutAttributes.frame.origin;
            origin.y = MIN(
                           MAX(
                               contentOffset.y + cv.contentInset.top,
                               (CGRectGetMinY(firstObjectAttrs.frame) - headerHeight)
                               ),
                           (CGRectGetMaxY(lastObjectAttrs.frame) - headerHeight)
                           );
            
            layoutAttributes.zIndex = 1024;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = layoutAttributes.frame.size
            };
            
        }
        
    }
    
    return answer;
    
}

/*
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}
*/

@end
