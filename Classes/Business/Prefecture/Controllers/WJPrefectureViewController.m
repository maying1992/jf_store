//
//  WJPrefectureViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPrefectureViewController.h"
#import "WJRefreshCollectionView.h"
#import "SDCycleScrollView.h"
#import "WJCategoryCollectionViewCell.h"
#import "WJHomeLoveCollectionViewCell.h"
#import "WJGoodsCollectionViewCell.h"

#import "WJGoodsListViewController.h"
#import "WJGoodsPlateViewController.h"
#import "WJLotteryDrawViewController.h"
#import "WJApplyStoreViewController.h"

#define kDefaultIdentifier              @"kDefaultIdentifier"
#define kCategoryIdentifier             @"kCategoryIdentifier"
#define kHomeLoveIdentifier             @"kHomeLoveIdentifier"
#define kGoodsIdentifier                @"kGoodsIdentifier"

@interface WJPrefectureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic, strong) WJRefreshCollectionView   * collectionView;
@property(nonatomic, strong) SDCycleScrollView         * cycleScrollView;

@end

@implementation WJPrefectureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"易购专区";
    [self hiddenBackBarButtonItem];
    [self navigationSetup];
    [self.view addSubview:self.collectionView];
}

- (void)navigationSetup
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 21);
    rightButton.titleLabel.font = WJFont14;
    [rightButton setTitle:@"申请店铺" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction
{
    WJApplyStoreViewController *applyStoreVC = [[WJApplyStoreViewController alloc]init];
    [self.navigationController pushViewController:applyStoreVC animated:YES];
}

#pragma mark - CollectionViewDelegate/CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        //轮播
        return 1;
    }else if(section == 1){
        //分类
        return 6;
    }else if(section == 2){
        //猜你喜欢
        return 1;
    }else{
        //商品
        return 8;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //轮播
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultIdentifier forIndexPath:indexPath];
        [cell.contentView addSubview:self.cycleScrollView];
        cell.backgroundColor = WJColorViewBg;
        return cell;
    }else if(indexPath.section == 1){
        //分类
        NSArray *imageArray = @[@"home_newborn-zone_icon",@"home_lucky-draw_icon",@"home_fmcg_icon",@"home_slow-food_icon",@"home_worldcom_icon",@"home_benefit-the-people_icon"];
        NSArray *titleArray = @[@"新人专区",@"抽奖专区",@"快消品板块",@"慢消品板块",@"世通专区",@"惠民专区"];
        
        WJCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCategoryIdentifier forIndexPath:indexPath];
        [cell conFigData:[UIImage imageNamed:imageArray[indexPath.row]] title:titleArray[indexPath.row]];
        return cell;
    }else if(indexPath.section == 2){
        WJHomeLoveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeLoveIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        WJGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsIdentifier forIndexPath:indexPath];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //轮播
        return CGSizeMake(kScreenWidth,kScreenWidth * 0.6);
    }else if(indexPath.section == 1){
        //分类
        return CGSizeMake(kScreenWidth/3, 90);
    }else if(indexPath.section == 2){
        //猜你喜欢的
        return CGSizeMake(kScreenWidth, 44);
    }else{
        return CGSizeMake((kScreenWidth-6)/2, (kScreenWidth-6)/2+76);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 3) {
        //商品
        return ALD(5);
    }else{
        return 0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row <=1) {
            WJGoodsListViewController * goodsListVC = [[WJGoodsListViewController alloc]init];
            [self.navigationController pushViewController:goodsListVC animated:YES];
        }else if (indexPath.row <= 3){
            WJGoodsPlateViewController * goodsPlateVC = [[WJGoodsPlateViewController alloc]init];
            [self.navigationController pushViewController:goodsPlateVC animated:YES];
        }else if (indexPath.row <= 5){
            WJLotteryDrawViewController * lotteryDrawVC = [[WJLotteryDrawViewController alloc]init];
            [self.navigationController pushViewController:lotteryDrawVC animated:YES];
        }
    }
    
}

#pragma mark - SDCycleScrollViewDelegate
//轮播选中代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - getter && setter
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _collectionView = [[WJRefreshCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarHeight - kStatusBarHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = WJColorViewBg;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //        [_collectionView refreshNow:NO refreshViewType:WJRefreshViewTypeHeader];
        
        //轮播
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultIdentifier];
        //分类
        [_collectionView registerClass:[WJCategoryCollectionViewCell class] forCellWithReuseIdentifier:kCategoryIdentifier];
        //猜你喜欢
        [_collectionView registerClass:[WJHomeLoveCollectionViewCell class] forCellWithReuseIdentifier:kHomeLoveIdentifier];
        //商品
        [_collectionView registerClass:[WJGoodsCollectionViewCell class] forCellWithReuseIdentifier:kGoodsIdentifier];
    }
    return _collectionView;
}


- (SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        NSArray *imageNames = @[[UIImage imageNamed:@"new_x1_19201200_01"],[UIImage imageNamed:@"new_x1_19201200_02"],[UIImage imageNamed:@"new_x1_19201200_03"],[UIImage imageNamed:@"new_x1_19201200_04"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.6) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        _cycleScrollView.autoScrollTimeInterval = 2;
    }
    return _cycleScrollView;
}



@end
