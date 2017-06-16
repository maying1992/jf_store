//
//  WJIntegralTradePasswordViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralTradePasswordViewController.h"
#import "WJPasswordSettingViewController.h"
#import "WJForgetIntegralPasswordViewController.h"
@interface WJIntegralTradePasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView              *tableView;

@end

@implementation WJIntegralTradePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分交易密码";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralTradePasswordCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntegralTradePasswordCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        
        
        UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(100), ALD(22))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.tag = 2001;
        
        [cell.contentView addSubview:nameL];
    }

    
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:2001];
    
    if (indexPath.row == 0) {
        
        nameL.text = @"设置交易密码";
    } else {
        
        nameL.text = @"重置交易密码";
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        WJPasswordSettingViewController *passwordSettingVC = [[WJPasswordSettingViewController alloc] init];
        passwordSettingVC.passwordType = PasswordTypeNew;
        passwordSettingVC.passwordSettingFrom = PasswordSettingFromOther;
        [self.navigationController pushViewController:passwordSettingVC animated:YES];
        
    } else {
        
        WJForgetIntegralPasswordViewController *forgetIntegralPasswordVC = [[WJForgetIntegralPasswordViewController alloc] init];
        [self.navigationController pushViewController:forgetIntegralPasswordVC animated:YES];

        
    }
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - ALD(44)) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
