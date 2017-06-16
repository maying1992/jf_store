//
//  WJCategoryView.m
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryView.h"
#import "WJProductCollectionViewCell.h"
#import "WJCategoryCell.h"
@interface WJCategoryView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)WJCategoryListModel *recordCatrgoryModel;
@end

@implementation WJCategoryView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.mainCollectionView];
        
    }
    return self;
}

#pragma mark - UITableViewDelagate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray.count > 0) {
        return self.dataArray.count;

    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(42);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryListCell"];
    if (cell == nil) {
        cell = [[WJCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

    }
    WJCategoryListModel *categoryListModel = [[WJCategoryListModel alloc]init];
    categoryListModel = self.dataArray[indexPath.row];
    
    [cell configDataWithCategoryListModel:categoryListModel];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJCategoryListModel *categoryListModel = [[WJCategoryListModel alloc]init];
    categoryListModel = self.dataArray[indexPath.row];
    categoryListModel.isSelect = YES;
    
    if (_recordCatrgoryModel) {
        _recordCatrgoryModel.isSelect = NO;
    }
    _recordCatrgoryModel = categoryListModel;
    
    self.selectCategoryBlock(_recordCatrgoryModel);
}


#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.collecDataArray.count > 0) {
        return self.collecDataArray.count;

    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionViewCell" forIndexPath:indexPath];
    WJCategoryProductModel *productModel = self.collecDataArray[indexPath.row];
    [cell configDataWithModel:productModel];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - 110 - 14)/2, (kScreenWidth - 110 - 14)/2 + 106);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJCategoryProductModel *productModel = self.collecDataArray[indexPath.row];
    self.productTapBlock(productModel);
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    self.selectBannerBlock(index);
}

#pragma mark - Setter And Getter
- (UICollectionView *)mainCollectionView
{
    if (_mainCollectionView == nil) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 8;
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _mainCollectionView = [[WJRefreshCollectionView alloc] initWithFrame:CGRectMake(ALD(90), _cycleScrollView.bottom + ALD(10), kScreenWidth - ALD(90), self.frame.size.height - kNavigationBarHeight - kTabbarHeight) collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = WJColorViewBg;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        [_mainCollectionView refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        
        
        [_mainCollectionView registerClass:[WJProductCollectionViewCell class] forCellWithReuseIdentifier:@"ProductCollectionViewCell"];
        [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DefaultCollectionViewCell"];
        
    }
    return _mainCollectionView;
}


- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ALD(90), self.frame.size.height) style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.backgroundColor = WJColorWhite;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        NSArray *imageNames = @[[UIImage imageNamed:@"new_x1_19201200_01"],[UIImage imageNamed:@"new_x1_19201200_02"],[UIImage imageNamed:@"new_x1_19201200_03"],[UIImage imageNamed:@"new_x1_19201200_04"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(_mainTableView.right + ALD(7), ALD(10), kScreenWidth - ALD(90) - ALD(14), ALD(82)) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        _cycleScrollView.autoScrollTimeInterval = 2;
    }
    return _cycleScrollView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)collecDataArray
{
    if (_collecDataArray == nil) {
        _collecDataArray = [NSMutableArray array];
    }
    return _collecDataArray;
}

@end
