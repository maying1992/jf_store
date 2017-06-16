//
//  WJIntegralGivingViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralGivingViewController.h"
#import "WJSystemAlertView.h"

@interface WJIntegralGivingViewController ()<UITableViewDelegate,UITableViewDataSource,WJSystemAlertViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UITableView     *tableView;
@property(nonatomic,strong)NSArray           *listArray;
@end

@implementation WJIntegralGivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赠送";
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
    UIButton *givingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [givingBtn setFrame:CGRectMake(0, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth, ALD(44))];
    [givingBtn setTitle:@"赠送" forState:UIControlStateNormal];
    [givingBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [givingBtn.titleLabel setFont:WJFont15];
    givingBtn.backgroundColor = WJColorMainColor;
    [givingBtn addTarget:self action:@selector(givingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:givingBtn];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"givingCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"givingCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
        
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(110), ALD(44))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.tag = 3001;
        [cell.contentView addSubview:nameL];
        
        UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(34) - ALD(220), 0, ALD(220), ALD(44))];
        contentTF.textColor = WJColorDardGray9;
        contentTF.font = WJFont14;
        contentTF.tag = 3002;
        contentTF.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentTF];
        
    }
    
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:3001];
    UITextField *contentTF = (UITextField *)[cell.contentView viewWithTag:3002];
    
    NSDictionary *dic = self.listArray[indexPath.row];
    nameL.text = dic[@"text"];
    
    if (indexPath.row == 0) {
        
        contentTF.userInteractionEnabled = NO;
        contentTF.text = @"A8888";
        
        
    } else if (indexPath.row == 1) {
        
        contentTF.text = @"李成";
        contentTF.userInteractionEnabled = NO;
        
        
    } else if (indexPath.row == 2) {
        
        contentTF.userInteractionEnabled = NO;
        contentTF.text = @"18838218310";
        
    } else {
        
        contentTF.userInteractionEnabled = YES;
        contentTF.placeholder = @"请输入积分";
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
-(void)givingBtnAction
{
    NSString *message = [NSString stringWithFormat:@"当前激活需红积分%@，可用积分%@是否确认激活?",@"4000",@"6000"];
    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"激活信息" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
    [alertView showIn];
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
