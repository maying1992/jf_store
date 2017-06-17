//
//  WJGoodsDetailViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/26.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsDetailViewController.h"
#import "WJBottonBarView.h"
#import "SDCycleScrollView.h"
#import "WJGoodsDetailTableViewCell.h"
#import "APIGoodsDetailsManager.h"
#import "WJGoodsDetailModel.h"
#import "WJGoodsDetailReformer.h"

@interface WJGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,APIManagerCallBackDelegate>

@property(nonatomic ,strong) WJBottonBarView                 * bottonBarView;
@property(nonatomic ,strong) UITableView                     * mainTableView;
@property(nonatomic, strong) SDCycleScrollView               * cycleScrollView;
@property(nonatomic, strong) APIGoodsDetailsManager          * goodsDetailsManager;
@property(nonatomic ,strong) NSMutableArray                   * dataArray;

@end

@implementation WJGoodsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
    [self UISetUp];
    [self.goodsDetailsManager loadData];
}


#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    self.dataArray = [manager fetchDataWithReformer:[WJGoodsDetailReformer new]];
    [self.mainTableView reloadData];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

- (void)backBarButton:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shoppingCartButton
{
    
}

- (void)collectButtonAction
{
    
}

- (void)addShopCarButtonAction
{
    
}

- (void)buyNowButtonAction
{
    
}


#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //轮播
        return kScreenWidth * 0.6;
    }else{
        return 120;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            [cell.contentView addSubview:self.cycleScrollView];
        }
        return cell;
    }else{
        WJGoodsDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJGoodsDetailTableViewCell"];
        if (cell == nil) {
            cell = [[WJGoodsDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJGoodsDetailTableViewCell"];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - SDCycleScrollViewDelegate
//轮播选中代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}


#pragma mark - Setter && Getter

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

- (void)UISetUp
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 26, 32, 32);
    [leftBtn setImage:[UIImage imageNamed:@"details-page_nav_btn_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(kScreenWidth - 47, 26, 32, 32);
    [rightBtn setImage:[UIImage imageNamed:@"details-page_nav_btn_shopping-cart"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shoppingCartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    [self.view addSubview:self.bottonBarView];
    [self.view addConstraints:[_bottonBarView constraintsSize:CGSizeMake(kScreenWidth, kTabbarHeight)]];
    [self.view addConstraints:[_bottonBarView constraintsLeftInContainer:0]];
    [self.view addConstraints:[_bottonBarView constraintsBottomInContainer:0]];
}



- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, -kStatusBarHeight, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (WJBottonBarView *)bottonBarView
{
    if (_bottonBarView == nil) {
        _bottonBarView = [[WJBottonBarView alloc]initForAutoLayout];
        _bottonBarView.backgroundColor = WJColorWhite;
        [_bottonBarView.collectButton addTarget:self action:@selector(collectButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottonBarView.addShopCarButton addTarget:self action:@selector(addShopCarButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottonBarView.buyNowButton addTarget:self action:@selector(buyNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bottonBarView;
}

- (APIGoodsDetailsManager *)goodsDetailsManager
{
    if (_goodsDetailsManager == nil) {
        _goodsDetailsManager = [[APIGoodsDetailsManager alloc]init];
        _goodsDetailsManager.delegate = self;
    }
    _goodsDetailsManager.goodsId = self.goodsId;
    return _goodsDetailsManager;
}

@end
