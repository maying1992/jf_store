
//
//  WJCanelOutputViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCanelOutputViewController.h"
#import "WJTradingHallOutputTableViewCell.h"

@interface WJCanelOutputViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView        * mainTableView;

@end

@implementation WJCanelOutputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    self.title = @"撤销卖出";
    [self.view addSubview:self.mainTableView];
}

- (void)outputButtonAction
{
    
}

- (void)cellCanelButtonAction:(UIButton *)button
{
    NSLog(@"点击了第%ld行按钮",button.tag-11000);
}


#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJTradingHallOutputTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[WJTradingHallOutputTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    [cell.cancelButton setTitle:@"撤销" forState:UIControlStateNormal];
    cell.cancelButton.titleLabel.font = WJFont15;
    [cell.cancelButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    cell.cancelButton.tag = 11000 + indexPath.row;
    [cell.cancelButton addTarget:self action:@selector(cellCanelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (void)UISetUp
{
    UIButton * outputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    outputButton.translatesAutoresizingMaskIntoConstraints = NO;
    [outputButton setTitle:@"卖出积分" forState:UIControlStateNormal];
    outputButton.titleLabel.font = WJFont16;
    [outputButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [outputButton setBackgroundColor:WJColorMainColor];
    [outputButton addTarget:self action:@selector(outputButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outputButton];
    [self.view addConstraints:[outputButton constraintsSize:CGSizeMake(kScreenWidth, 44)]];
    [self.view addConstraints:[outputButton constraintsBottomInContainer:0]];
    
}

@end
