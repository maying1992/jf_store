
//
//  WJLotteryDrawViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawViewController.h"
#import "WJLotteryDrawTableViewCell.h"
#import "APIPrizeGoodsListManager.h"
#import "WJLotteryGrawReformer.h"
#import "WJLotteryDrawListModel.h"

#import "WJWinnerListViewController.h"
#import "WJLotteryDrawDetailViewController.h"

@interface WJLotteryDrawViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>

@property(nonatomic ,strong) UITableView                    * mainTableView;
@property(nonatomic ,strong) APIPrizeGoodsListManager       * prizeGoodsListManager;
@property(nonatomic ,strong) NSMutableArray                   * dataArray;

@end

@implementation WJLotteryDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抽奖专区";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
    [self navigationSetup];
    [self.prizeGoodsListManager loadData];
}

- (void)navigationSetup
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 21);
    rightButton.titleLabel.font = WJFont14;
    [rightButton setTitle:@"中奖查询" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction
{
    WJWinnerListViewController * winnerLisrVC = [[WJWinnerListViewController alloc]init];
    [self.navigationController pushViewController:winnerLisrVC animated:YES];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    self.dataArray = [manager fetchDataWithReformer:[WJLotteryGrawReformer new]];
    [self.mainTableView reloadData];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJLotteryDrawTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJLotteryDrawTableViewCell"];
    if (cell == nil) {
        cell = [[WJLotteryDrawTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJLotteryDrawTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell configDataWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJLotteryDrawDetailViewController * lotteryDrawDetailVC = [[WJLotteryDrawDetailViewController alloc]init];
    WJLotteryDrawListModel * model = self.dataArray[indexPath.row];
    lotteryDrawDetailVC.prizeId = model.prizeId;
    [self.navigationController pushViewController:lotteryDrawDetailVC animated:YES];
}

#pragma mark - Setter && Getter
- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = WJColorViewBg;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIPrizeGoodsListManager *)prizeGoodsListManager
{
    if (_prizeGoodsListManager == nil) {
        _prizeGoodsListManager = [[APIPrizeGoodsListManager alloc]init];
        _prizeGoodsListManager.delegate = self;
    }
    return _prizeGoodsListManager;
}



@end
