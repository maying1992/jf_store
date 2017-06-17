//
//  WJLotteryDrawDetailViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/31.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawDetailViewController.h"
#import "SDCycleScrollView.h"
#import "APIPrizeGoodsDetailsManager.h"
#import "WJLotteryDrawDetailReformer.h"
#import "WJLotteryDrawDetailModel.h"
#import "WJWebTableViewCell.h"
#import "WJLotteryDrawDetailCell.h"
#import "WJLotteryDrawDetailModel.h"

@interface WJLotteryDrawDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,APIManagerCallBackDelegate,ReloadWebViewDelegate>
{
    CGFloat       productDetailCellHight;
}


@property(nonatomic ,strong) UITableView                     * mainTableView;
@property(nonatomic, strong) SDCycleScrollView               * cycleScrollView;
@property(nonatomic, strong) APIPrizeGoodsDetailsManager     * prizeGoodsDetailsManager;
@property(nonatomic ,strong) WJLotteryDrawDetailModel        * dataModel;


@end

@implementation WJLotteryDrawDetailViewController

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
    [self.prizeGoodsDetailsManager loadData];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    self.dataModel = [manager fetchDataWithReformer:[WJLotteryDrawDetailReformer new]];
    [self.mainTableView reloadData];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

- (void)backBarButton:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ReloadWebViewDelegate
- (void)reloadByHeight:(CGFloat)height
{
    productDetailCellHight = height;
    [self.mainTableView reloadData];
}

#pragma mark UITableViewDelegate && UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //轮播
        return kScreenWidth * 0.6;
    }else if (indexPath.row == 1) {
        return 105;
    }else{
        return productDetailCellHight;
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
    }else if(indexPath.row == 1){
        WJLotteryDrawDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJLotteryDrawDetailCell"];
        if (cell == nil) {
            cell = [[WJLotteryDrawDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJLotteryDrawDetailCell"];
        }
        [cell configDataWithModel:self.dataModel];
        return cell;
    }else{
        //商品详情
        WJWebTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WebCell"];
        if (!cell) {
            cell = [[WJWebTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WebCell"];
            cell.heightDelegate = self;
        }
        if (self.dataModel != nil && productDetailCellHight == 0) {
            [cell configWithURL:self.dataModel.linkUrl];
        }
        cell.contentView.backgroundColor = WJRandomColor;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    
    UIButton * outputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    outputButton.translatesAutoresizingMaskIntoConstraints = NO;
    [outputButton setTitle:@"立即抽奖" forState:UIControlStateNormal];
    outputButton.titleLabel.font = WJFont16;
    [outputButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [outputButton setBackgroundColor:WJColorMainColor];
    [outputButton addTarget:self action:@selector(outputButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outputButton];
    [self.view addConstraints:[outputButton constraintsSize:CGSizeMake(kScreenWidth, kTabbarHeight)]];
    [self.view addConstraints:[outputButton constraintsBottomInContainer:0]];

}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, - kStatusBarHeight, kScreenWidth, kScreenHeight - kTabbarHeight +kStatusBarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIPrizeGoodsDetailsManager *)prizeGoodsDetailsManager
{
    if (_prizeGoodsDetailsManager == nil) {
        _prizeGoodsDetailsManager = [[APIPrizeGoodsDetailsManager alloc]init];
        _prizeGoodsDetailsManager.delegate = self;
    }
    _prizeGoodsDetailsManager.prizeId = self.prizeId;
    return _prizeGoodsDetailsManager;
}

@end
