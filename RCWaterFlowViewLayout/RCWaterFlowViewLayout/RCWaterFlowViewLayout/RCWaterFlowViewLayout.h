//
//  RCWaterFlowViewLayout.h
//  瀑布流
//
//  Created by RongCheng on 16/9/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCWaterFlowViewLayout;
@protocol RCWaterFlowViewLayoutDelegate <NSObject>

@required
/**
 * 必选方法，
 * waterflowLayout :自定义的Layout
 * index : item所在的index
 * itemWidth : item的宽度
 */
- (CGFloat)waterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/**传入列数，不传默认3列*/
- (CGFloat)columnCountInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout;
/**传入列间距，不传默认10*/
- (CGFloat)columnMarginInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout;
/**传入行间距，不传默认10*/
- (CGFloat)rowMarginInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout;
/**传入collectionView的EdgeInsets，不传默认（10, 10, 10, 10）*/
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout;

@end

@interface RCWaterFlowViewLayout : UICollectionViewLayout
/**代理*/
@property (nonatomic,weak) id <RCWaterFlowViewLayoutDelegate> delegate;
@end
