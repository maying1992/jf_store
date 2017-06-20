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

typedef enum
{
    ButtonStatusNormal,   //无状态
    ButtonStatusAscend,
    ButtonStatusDescend
} ButtonStatus;


@interface WJGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,APIManagerCallBackDelegate>
{
    WJTitleButton * salesButton;
    WJTitleButton * priceButton;
    WJTitleButton * timeButton;
    BOOL            isHeaderRefresh;
    BOOL            isFooterRefresh;
//    NSInteger       numStatus;
}

@property(nonatomic,strong)WJRefreshCollectionView             * mainCollectionView;
@property(nonatomic,strong)UIView                       * guidanceView;
@property(nonatomic,strong)APIGoodsListManager          * goodsListManager;
@property(nonatomic,strong)NSMutableArray               * dataArray;
@property(nonatomic,assign)ButtonStatus                  numButtonStatus;
@property(nonatomic,assign)ButtonStatus                  priceButtonStatus;

@end

@implementation WJGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    self.isHiddenTabBar = YES;
    
    _numButtonStatus = ButtonStatusNormal;
    _priceButtonStatus = ButtonStatusNormal;

    [self.view addSubview:self.mainCollectionView];
    [self.view addSubview:self.guidanceView];

    [self.goodsListManager loadData];
}

#pragma mark - WJRefreshTableView Delegate

- (void)startHeadRefreshToDo:(WJRefreshCollectionView *)collectionView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.goodsListManager.shouldCleanData = YES;
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        [self.goodsListManager loadData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshCollectionView *)collectionView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.goodsListManager.shouldCleanData = NO;
        [self.goodsListManager loadData];
    }
}

- (void)endGetData:(BOOL)needReloadData{
    
    if (isHeaderRefresh) {
        isHeaderRefresh = NO;
        [self.mainCollectionView endHeadRefresh];
    }
    
    if (isFooterRefresh){
        isFooterRefresh = NO;
        [self.mainCollectionView endFootFefresh];
    }
    
    if (needReloadData) {
        [self.mainCollectionView reloadData];
    }
}

- (void)refreshFooterStatus:(BOOL)status{
    
    if (status) {
        [self.mainCollectionView hiddenFooter];
    }else {
        [self.mainCollectionView showFooter];
    }
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSArray * array = [manager fetchDataWithReformer:[WJGoodsListReformer new]];
    [self.dataArray addObjectsFromArray:array];
    [self endGetData:YES];
    [self refreshFooterStatus:manager.hadGotAllData];
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
        [_mainCollectionView refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        
        
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
        
        UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        [_guidanceView addSubview:bottomLine];
    }
    return _guidanceView;
}

- (void)brandClick:(UIButton *)button
{
    [self button:button buttonIsSelect:YES];
}


- (void)button:(UIButton *)button buttonIsSelect:(BOOL)isSelect
{
    NSInteger buttonTag = button.tag - 12000;
    CGPoint center;
    if (buttonTag == 0) {
        if (isSelect) {
            if (_numButtonStatus == ButtonStatusNormal) {
                button.selected = !button.selected;
                _numButtonStatus = ButtonStatusDescend;
                self.goodsListManager.orderType = @"desc";
                [salesButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
                [salesButton setImage:[UIImage imageNamed:@"classified-screening_icon_n"] forState:UIControlStateNormal];
            }else if (_numButtonStatus == ButtonStatusDescend){
                _numButtonStatus = ButtonStatusAscend;
                self.goodsListManager.orderType = @"asc";
                [salesButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
                [salesButton setImage:[UIImage imageNamed:@"classified-screening_icon_s"] forState:UIControlStateNormal];
            }else{
                _numButtonStatus = ButtonStatusDescend;
                self.goodsListManager.orderType = @"desc";
                [salesButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
                [salesButton setImage:[UIImage imageNamed:@"classified-screening_icon_n"] forState:UIControlStateNormal];
            }
            _priceButtonStatus = ButtonStatusNormal;
            [priceButton setTitleColor:WJColorMainTitle forState:UIControlStateNormal];
            [priceButton setImage:[UIImage imageNamed:@"classified-screening_icon"] forState:UIControlStateNormal];
            self.goodsListManager.orderField = @"ale_num";
            self.goodsListManager.shouldCleanData = YES;
            [self.goodsListManager loadData];
        }
        center.y = _guidanceView.center.y;
        center.x = _guidanceView.center.x/2;
        button.center = center;
    }else if (buttonTag == 1){
        if (isSelect) {
            if (_priceButtonStatus == ButtonStatusNormal) {
                button.selected = !button.selected;
                _priceButtonStatus = ButtonStatusDescend;
                self.goodsListManager.orderType = @"desc";
                [priceButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
                [priceButton setImage:[UIImage imageNamed:@"classified-screening_icon_n"] forState:UIControlStateNormal];
            }else if (_priceButtonStatus == ButtonStatusDescend){
                _priceButtonStatus = ButtonStatusAscend;
                self.goodsListManager.orderType = @"asc";
                [priceButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
                [priceButton setImage:[UIImage imageNamed:@"classified-screening_icon_s"] forState:UIControlStateNormal];
            }else{
                _priceButtonStatus = ButtonStatusDescend;
                self.goodsListManager.orderType = @"desc";
                [priceButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
                [priceButton setImage:[UIImage imageNamed:@"classified-screening_icon_n"] forState:UIControlStateNormal];
            }
            _numButtonStatus = ButtonStatusNormal;
            [salesButton setTitleColor:WJColorMainTitle forState:UIControlStateNormal];
            [salesButton setImage:[UIImage imageNamed:@"classified-screening_icon"] forState:UIControlStateNormal];
            
            self.goodsListManager.orderField = @"selling_price";
            self.goodsListManager.shouldCleanData = YES;
            [self.goodsListManager loadData];
        }
        center.y = _guidanceView.center.y;
        center.x = _guidanceView.center.x + _guidanceView.center.x/2;
        button.center = center;
    }
}

- (APIGoodsListManager *)goodsListManager
{
    if (_goodsListManager == nil) {
        _goodsListManager = [[APIGoodsListManager alloc]init];
        _goodsListManager.delegate = self;
    }
    _goodsListManager.categoryID = self.categoryID?:@"";
    return _goodsListManager;
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
