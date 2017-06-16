//
//  WJGoodsListViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsListViewController.h"
#import "WJTitleButton.h"
#import "WJGoodsCollectionViewCell.h"
#import "WJRefreshCollectionView.h"
#import "APIGoodsListManager.h"
#import "WJGoodsListReformer.h"

#define kGoodsIdentifier                @"kGoodsIdentifier"

@interface WJGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,APIManagerCallBackDelegate>
{
    WJTitleButton * salesButton;
    WJTitleButton * priceButton;
    WJTitleButton * timeButton;
}

@property(nonatomic,strong)UICollectionView             * mainCollectionView;
@property(nonatomic,strong)UIView                       * guidanceView;
@property(nonatomic,strong)APIGoodsListManager          * goodsListManager;
@property(nonatomic,strong)NSMutableArray               * dataArray;

@end

@implementation WJGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.mainCollectionView];
    [self.view addSubview:self.guidanceView];

    [self.goodsListManager loadData];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    self.dataArray = [manager fetchDataWithReformer:[WJGoodsListReformer new]];
    [self.mainCollectionView reloadData];

}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsIdentifier forIndexPath:indexPath];
    [cell configDataWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-6)/2, (kScreenWidth-6)/2+76);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ALD(5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击分类第%ld个cell",(long)indexPath.row);
}


#pragma mark - getter&&setter
-(UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _mainCollectionView = [[WJRefreshCollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40 - kStatusBarHeight) collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = WJColorViewBg;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        
//        [_collectionView refreshNow:NO refreshViewType:WJRefreshViewTypeHeader];
        //商品
        [_mainCollectionView registerClass:[WJGoodsCollectionViewCell class] forCellWithReuseIdentifier:kGoodsIdentifier];
    }
    return _mainCollectionView;
}

- (UIView *)guidanceView
{
    if (_guidanceView == nil) {
        _guidanceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _guidanceView.backgroundColor = WJColorWhite;
        
        salesButton = [[WJTitleButton alloc] init];
        salesButton.tag = 12000;
        [salesButton setTitle:@"销量" forState:UIControlStateNormal];
        [self button:salesButton buttonIsSelect:NO];
        [salesButton addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchUpInside];
        [_guidanceView addSubview:salesButton];
        
        priceButton = [[WJTitleButton alloc] init];
        priceButton.tag = 12001;
        [priceButton setTitle:@"价格" forState:UIControlStateNormal];
        [self button:priceButton buttonIsSelect:NO];
        [priceButton addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchUpInside];
        [_guidanceView addSubview:priceButton];
        
//        timeButton = [[WJTitleButton alloc] init];
//        timeButton.tag = 12002;
//        [timeButton setTitle:@"时间" forState:UIControlStateNormal];
//        [self button:timeButton buttonIsSelect:NO];
//        [timeButton addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_guidanceView addSubview:timeButton];
        
        UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        [_guidanceView addSubview:bottomLine];
    }
    return _guidanceView;
}

- (void)brandClick:(UIButton *)button
{
    button.selected = !button.selected;
    [self button:button buttonIsSelect:YES];
}

- (void)button:(UIButton *)button buttonIsSelect:(BOOL)isSelect
{
    NSInteger buttonTag = button.tag - 12000;
    CGPoint center;
    if (buttonTag == 0) {
        if (isSelect) {
            priceButton.selected = NO;
//            timeButton.selected = NO;
        }
        center.y = _guidanceView.center.y;
        center.x = _guidanceView.center.x/2;
        button.center = center;
    }else if (buttonTag == 1){
        if (isSelect) {
            salesButton.selected = NO;
//            timeButton.selected = NO;
        }
        center.y = _guidanceView.center.y;
        center.x = _guidanceView.center.x + _guidanceView.center.x/2;
        button.center = center;
    }else{
//        if (isSelect) {
//            salesButton.selected = NO;
//            priceButton.selected = NO;
//        }
//        center.y = _guidanceView.center.y;
//        center.x = (_guidanceView.center.x/3)*2 + _guidanceView.center.x;
//        button.center = center;
    }
}

- (APIGoodsListManager *)goodsListManager
{
    if (_goodsListManager == nil) {
        _goodsListManager = [[APIGoodsListManager alloc]init];
        _goodsListManager.delegate = self;
    }
    return _goodsListManager;
}


@end
