//
//  ViewController.m
//  瀑布流
//
//  Created by RongCheng on 16/9/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "ViewController.h"
#import "RCShopModel.h"
#import "RCCollectionViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "RCWaterFlowViewLayout.h"
@interface ViewController ()<RCWaterFlowViewLayoutDelegate,UICollectionViewDataSource>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController
- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString * const RCShopId = @"shop";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
    
    [self setupRefresh];
}
- (void)setupLayout
{
    // 创建布局
    RCWaterFlowViewLayout *layout = [[RCWaterFlowViewLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RCCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:RCShopId];
    
    self.collectionView = collectionView;
}
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.hidden = YES;
}
- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [RCShopModel mj_objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [RCShopModel mj_objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
    });
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RCShopId forIndexPath:indexPath];
    
    cell.model = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - <XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    RCShopModel *shop = self.shops[index];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout
{
    return 20;
}

- (CGFloat)columnCountInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout
{
    if (self.shops.count <= 50) return 2;
    else if (self.shops.count <= 100)  return 3;
    return 4;
}
/**
 *  设置EdgeInsets
 */
 
/*- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(RCWaterFlowViewLayout *)waterflowLayout
 {
 return UIEdgeInsetsMake(10, 20, 30, 100);
 }
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
