//
//  WJWinnerListViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJWinnerListViewController.h"
#import "WJWinnerListTableViewCell.h"
#import "APIPrizeResultListManager.h"
#import "WJPrizeResultListReformer.h"

@interface WJWinnerListViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>

@property(nonatomic ,strong) UITableView                      * mainTableView;
@property(nonatomic ,strong) APIPrizeResultListManager        * prizeResultListManager;
@property(nonatomic ,strong) NSMutableArray                   * dataArray;

@end

@implementation WJWinnerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中奖名单";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
    [self.prizeResultListManager loadData];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    self.dataArray = [manager fetchDataWithReformer:[WJPrizeResultListReformer new]];
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
    return self.dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJWinnerListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJWinnerListTableViewCell"];
    if (cell == nil) {
        cell = [[WJWinnerListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJWinnerListTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    }
    if (indexPath.row > 0) {
        [cell configDataWithModel:self.dataArray[indexPath.row - 1]];
    }
    return cell;
}


#pragma mark - Setter && Getter
- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = WJColorWhite;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIPrizeResultListManager *)prizeResultListManager
{
    if (_prizeResultListManager == nil) {
        _prizeResultListManager = [[APIPrizeResultListManager alloc]init];
        _prizeResultListManager.delegate = self;
    }
    return _prizeResultListManager;
}

@end
