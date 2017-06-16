
//
//  WJGoodsPlateViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsPlateViewController.h"
#import "APIIndexCategoryManager.h"
#import "WJGoodsPlateReformer.h"

#define kDefaultIdentifier              @"kDefaultIdentifier"

@interface WJGoodsPlateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,APIManagerCallBackDelegate>


@property(nonatomic,strong) UICollectionView                * collectionView;
@property(nonatomic,strong) APIIndexCategoryManager         * indexCategoryManager;
@property(nonatomic,strong)NSMutableArray                   * dataArray;

@end


@implementation WJGoodsPlateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    
    self.title = @"快消品板块";
    [self.view addSubview:self.collectionView];
    [self.indexCategoryManager loadData];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    self.dataArray = [manager fetchDataWithReformer:[WJGoodsPlateReformer new]];
    [self.collectionView reloadData];
    
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

#pragma mark - CollectionViewDelegate/CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultIdentifier forIndexPath:indexPath];
    cell.backgroundColor = WJColorWhite;
    UIImageView *imagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.width)];
    imagView.image = [WJUtilityMethod createImageWithColor:WJRandomColor];
    [cell.contentView addSubview:imagView];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.width, cell.width, 28)];
    titleLabel.font = WJFont14;
    titleLabel.text = @"大家电";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = WJColorMainTitle;
    [cell.contentView addSubview:titleLabel];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - 41)/3,(kScreenWidth - 41)/3 + 28);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - getter && setter
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarHeight - kStatusBarHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = WJColorViewBg;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultIdentifier];
    }
    return _collectionView;
}

- (APIIndexCategoryManager *)indexCategoryManager
{
    if (_indexCategoryManager == nil) {
        _indexCategoryManager = [[APIIndexCategoryManager alloc]init];
        _indexCategoryManager.delegate = self;
    }
    _indexCategoryManager.channelId = self.channelId;
    return _indexCategoryManager;
}


@end
