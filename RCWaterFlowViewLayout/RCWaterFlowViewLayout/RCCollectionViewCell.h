//
//  RCCollectionViewCell.h
//  瀑布流
//
//  Created by RongCheng on 16/9/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCShopModel;
@interface RCCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) RCShopModel * model;
@end
