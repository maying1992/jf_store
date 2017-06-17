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
#import "APIPrizeNowManager.h"
#import "WJPassView.h"
#import "WJSystemAlertView.h"


@interface WJLotteryDrawDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,APIManagerCallBackDelegate,ReloadWebViewDelegate,WJPassViewDelegate,WJSystemAlertViewDelegate>
{
    CGFloat       productDetailCellHight;
}


@property(nonatomic ,strong) UITableView                     * mainTableView;
@property(nonatomic, strong) SDCycleScrollView               * cycleScrollView;
@property(nonatomic, strong) APIPrizeGoodsDetailsManager     * prizeGoodsDetailsManager;
@property(nonatomic, strong) APIPrizeNowManager              * prizeNowManager;
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

- (void)outputButtonAction
{
    
    WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
    passView.delegate = self;
    [passView showIn];
//    self.payType = order.payType;
    
//    self.orderModel = order;

}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isMemberOfClass:[APIPrizeNowManager class]]) {
        ALERT(@"抽奖成功");
    }
    self.dataModel = [manager fetchDataWithReformer:[WJLotteryDrawDetailReformer new]];
    [self.mainTableView reloadData];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

- (void)backBarButton:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WJPassViewDelegate
- (void)successWithVerifyPsdAlert:(WJPassView *)alertView
{
    NSLog(@"111");
    self.prizeNowManager.password = alertView.enterPassword;
    [self.prizeNowManager loadData];
}

- (void)failedWithVerifyPsdAlert:(WJPassView *)alertView errerMessage:(NSString * )errerMessage
{
    NSLog(@"222");
    [alertView dismiss];
    [self showAlertWithMessage:errerMessage];
    
}

-(void)setTradePasswordActionWith:(WJPassView *)alertView
{
    NSLog(@"333");

    [alertView dismiss];
    
//    WJIntegralTradePasswordViewController *integralTradePasswordViewController = [[WJIntegralTradePasswordViewController alloc] init];
//    [self.navigationController pushViewController:integralTradePasswordViewController animated:YES];
}

- (void)forgetPasswordActionWith:(WJPassView *)alertView
{
    NSLog(@"444");

    [alertView dismiss];
    
//    WJIntegralTradePasswordViewController *integralTradePasswordViewController = [[WJIntegralTradePasswordViewController alloc] init];
//    [self.navigationController pushViewController:integralTradePasswordViewController animated:YES];
}

#pragma mark - WJSystemAlertViewDelegate
- (void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //取消
    if (buttonIndex == 0) {
        [alertView dismiss];
        
    } else {
        
        WJPassView *passView = [[WJPassView alloc] initWithFrame:self.view.bounds title:@"请输入支付密码"];
        passView.delegate = self;
        [passView showIn];
    }
}



- (void)showAlertWithMessage:(NSString *)msg
{
    WJSystemAlertView *sysAlert = [[WJSystemAlertView alloc] initWithTitle:@"验证失败" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再试一次" textAlignment:NSTextAlignmentCenter];
    
    [sysAlert showIn];
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

- (APIPrizeNowManager *)prizeNowManager
{
    if (_prizeNowManager == nil) {
        _prizeNowManager = [[APIPrizeNowManager alloc]init];
        _prizeNowManager.delegate = self;
    }
    _prizeNowManager.prizeId = self.prizeId;
    _prizeNowManager.count = @"1";
    return _prizeNowManager;
}

@end
