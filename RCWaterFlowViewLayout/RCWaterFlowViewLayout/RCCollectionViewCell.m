//
//  RCCollectionViewCell.m
//  瀑布流
//
//  Created by RongCheng on 16/9/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCCollectionViewCell.h"
#import "RCShopModel.h"
#import "UIImageView+WebCache.h"

@interface RCCollectionViewCell();
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation RCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(RCShopModel *)model{
    _model = model;
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] ];
    
    // 2.价格
    self.priceLabel.text = model.price;
}

@end
