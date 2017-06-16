//
//  WJGivingApplyViewController.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingApplyViewController.h"

@interface WJGivingApplyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView     *tableView;
@property(nonatomic,strong)NSArray           *listArray;
@end

@implementation WJGivingApplyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赠送申请";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    [self initBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBottomView
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth/2, ALD(44))];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:WJFont15];
    confirmBtn.backgroundColor = WJColorMainColor;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    UIButton *refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refuseBtn setFrame:CGRectMake(confirmBtn.right, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth/2, ALD(44))];
    [refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuseBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [refuseBtn.titleLabel setFont:WJFont15];
    refuseBtn.backgroundColor = [WJUtilityMethod colorWithHexColorString:@"#d2d2d2"];
    [refuseBtn addTarget:self action:@selector(refuseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refuseBtn];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activateCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activateCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
        
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(110), ALD(44))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.tag = 3001;
        [cell.contentView addSubview:nameL];
        
        UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(34) - ALD(220), 0, ALD(220), ALD(44))];
        contentL.textColor = WJColorDardGray9;
        contentL.font = WJFont14;
        contentL.tag = 3002;
        contentL.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentL];
        
    }
    
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:3001];
    UILabel *contentL = (UILabel *)[cell.contentView viewWithTag:3002];
    
    NSDictionary *dic = self.listArray[indexPath.row];
    nameL.text = dic[@"text"];
    
    if (indexPath.row == 0) {
        
        contentL.text = @"A8888";
        
        
    } else if (indexPath.row == 1) {
        
        contentL.text = @"李成";
        
        
    } else if (indexPath.row == 2) {
        
        contentL.text = @"18838218310";
        
    } else {
        
        contentL.text = @"90000积分";
    }
    
    
    return cell;
}

#pragma mark - Action
-(void)confirmAction
{
    
}


-(void)refuseAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = WJColorViewBg2;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(NSArray *)listArray
{
    return @[
             @{@"text":@"用户编码"},
             @{@"text":@"真实姓名"},
             @{@"text":@"联系方式"},
             @{@"text":@"赠送积分"}
             ];
}

@end
