//
//  WJSettingViewController.m
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSettingViewController.h"

@interface WJSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *logoutButton;
}
@property(nonatomic,strong)UITableView  *tableView;

@end

@implementation WJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.isHiddenTabBar = YES;
    [self UISetup];
}

-(void)UISetup
{
    [self.view addSubview:self.tableView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(100))];
    bgView.backgroundColor = WJColorViewBg;
    [self.view addSubview:bgView];
    
    logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(ALD(20), ALD(40), kScreenWidth - ALD(40), ALD(40));
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [logoutButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorViewNotEditable] forState:UIControlStateDisabled];
    [logoutButton setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorMainColor] forState:UIControlStateNormal];
    logoutButton.layer.cornerRadius = 4;
    logoutButton.layer.masksToBounds = YES;
    logoutButton.titleLabel.font = WJFont14;
    [self.view addSubview:logoutButton];
    
    if (USER_ID) {
        logoutButton.enabled = YES;
        
    } else {
        logoutButton.enabled = NO;

    }
    
    [logoutButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = bgView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ALD(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Action
-(void)logoutButtonAction
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserInformation];
    ALERT(@"成功退出");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IndividualCenterRefresh" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter&getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableView;
}


@end
