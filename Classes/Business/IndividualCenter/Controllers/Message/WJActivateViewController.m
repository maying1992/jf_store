//
//  WJActivateViewController.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJActivateViewController.h"
#import "WJSystemAlertView.h"
@interface WJActivateViewController ()<UITableViewDelegate,UITableViewDataSource,WJSystemAlertViewDelegate>
@property (nonatomic, strong)UITableView     *tableView;
@property(nonatomic,strong)NSArray           *listArray;

@end

@implementation WJActivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激活";
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
    UIButton *activateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [activateBtn setFrame:CGRectMake(0, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth/2, ALD(44))];
    [activateBtn setTitle:@"激活" forState:UIControlStateNormal];
    [activateBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [activateBtn.titleLabel setFont:WJFont15];
    activateBtn.backgroundColor = WJColorMainColor;
    [activateBtn addTarget:self action:@selector(activateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activateBtn];
    
    UIButton *refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refuseBtn setFrame:CGRectMake(activateBtn.right, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth/2, ALD(44))];
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
        
        contentL.text = @"10000积分";
    }
    
    
    return cell;
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        
    }
}

#pragma mark - Action
-(void)activateAction
{
    NSString *message = [NSString stringWithFormat:@"当前激活需红积分%@，可用积分%@是否确认激活?",@"4000",@"6000"];
    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"激活信息" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
    [alertView showIn];
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
             @{@"text":@"待激活会员编码"},
             @{@"text":@"真实姓名"},
             @{@"text":@"联系方式"},
             @{@"text":@"激活积分"}
             ];
}


@end
