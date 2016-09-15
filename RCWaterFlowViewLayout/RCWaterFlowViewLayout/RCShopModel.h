//
//  RCShopModel.h
//  瀑布流
//
//  Created by RongCheng on 16/9/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RCShopModel : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
@end
