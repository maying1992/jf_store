//
//  WJWinnerListViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJWinnerListViewController.h"
#import "WJWinnerListTableViewCell.h"

@interface WJWinnerListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView     *mainTableView;

@end

@implementation WJWinnerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中奖名单";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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

@end
