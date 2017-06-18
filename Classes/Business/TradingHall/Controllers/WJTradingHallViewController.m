//
//  WJTradingHallViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallViewController.h"
#import "WJKLineView.h"
#import "WJTradingHallTableViewCell.h"
#import "WJTabBarController.h"
#import "APITradeHallFeeManager.h"
#import "WJTradeHallfeeReformer.h"

#import "WJLoginController.h"
#import "WJTradingHallRechargeViewController.h"
#import "WJTradingHallOutputViewController.h"
#import "WJTradingHallInputViewController.h"

#define klineViewW      280
@interface WJTradingHallViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>

@property(nonatomic ,strong) WJKLineView                *kLineView;
@property(nonatomic ,strong) UITableView                *mainTableView;
@property(nonatomic ,assign) BOOL                        isRecharge;
@property(nonatomic ,strong) APITradeHallFeeManager     * tradeHallFeeManager;


@end

@implementation WJTradingHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易大厅";
    self.view.backgroundColor = WJColorViewBg;
    [self.view addSubview:self.kLineView];
    [self.view addSubview:self.mainTableView];
    [self navigationSetup];
    [self hiddenBackBarButtonItem];
    [self tradingHallResponse];
    [kDefaultCenter addObserver:self selector:@selector(tradingHallResponse) name:kTraingHallVCResponse object:nil];
    [kDefaultCenter addObserver:self selector:@selector(checkingIsPay) name:KCheckingIsPay object:nil];
    [kDefaultCenter addObserver:self selector:@selector(goOutVC) name:kTraingHallVCGoOutVC object:nil];

}

- (void)navigationSetup
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0,30, 21);
    rightButton.titleLabel.font = WJFont14;
    [rightButton setTitle:@"续费" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary * dic = [manager fetchDataWithReformer:[WJTradeHallfeeReformer new]];
    if ([dic[@"is_pay"] isEqualToString:@"2"]) {
        WJTradingHallRechargeViewController * rechargeVC = [[WJTradingHallRechargeViewController alloc]init];
        rechargeVC.dataArray = dic[@"admission_list"];
        rechargeVC.rechargeFrom = TradingHallRechargeFromTradingHallView;
        WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:rechargeVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

#pragma mark - BUtton Action

- (void)tradingHallResponse
{
    NSLog(@"1111");
    if (!USER_ID) {
        WJLoginController *loginVC = [[WJLoginController alloc]init];
        loginVC.loginFrom = LoginFromTradingHallView;
        WJNavigationController *Navigation = [[WJNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:Navigation animated:YES completion:nil];
    }else{
        [self.tradeHallFeeManager loadData];
    }
}

- (void)checkingIsPay
{
    [self.tradeHallFeeManager loadData];
}

- (void)goOutVC
{
    WJTabBarController * tab = (WJTabBarController *)self.tabBarController;
    if([WJGlobalVariable sharedInstance].tabBarIndex != 2){
        [tab changeTabIndex:[WJGlobalVariable sharedInstance].tabBarIndex];
    }
}

- (void)rightButtonAction
{
    WJTradingHallRechargeViewController * rechargeVC = [[WJTradingHallRechargeViewController alloc]init];
    WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:rechargeVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)outputButtonAction
{
    WJTradingHallOutputViewController * outputVC = [[WJTradingHallOutputViewController alloc]init];
    [self.navigationController pushViewController:outputVC animated:YES];
}

- (void)inputButtonAction
{
    WJTradingHallInputViewController * inputVC = [[WJTradingHallInputViewController alloc]init];
    [self.navigationController pushViewController:inputVC animated:YES];

}

#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJTradingHallTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJTradingHallTableViewCell"];
    if (cell == nil) {
        cell = [[WJTradingHallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJTradingHallTableViewCell"];
    }
    return cell;
    
}

- (WJKLineView *)kLineView
{
    if (_kLineView == nil) {
        _kLineView = [[WJKLineView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, klineViewW)];
        _kLineView.backgroundColor = WJColorWhite;
        [_kLineView.inputButton addTarget:self action:@selector(inputButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_kLineView.outputButton addTarget:self action:@selector(outputButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kLineView;
}


- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, klineViewW + 10, kScreenWidth, kScreenHeight - klineViewW - 10) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APITradeHallFeeManager *)tradeHallFeeManager
{
    if (_tradeHallFeeManager == nil) {
        _tradeHallFeeManager = [[APITradeHallFeeManager alloc]init];
        _tradeHallFeeManager.delegate = self;
    }
    return _tradeHallFeeManager;
}

@end
