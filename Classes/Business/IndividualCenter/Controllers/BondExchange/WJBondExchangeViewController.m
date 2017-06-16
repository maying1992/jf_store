//
//  WJBondExchangeViewController.m
//  jf_store
//
//  Created by reborn on 17/5/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBondExchangeViewController.h"
#import "WJConsumerActivateViewController.h"
#import "WJRechargeRedIntegralViewController.h"
#import "WJSystemAlertView.h"
#import "WJBondRecycleViewController.h"
@interface WJBondExchangeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WJSystemAlertViewDelegate>
{
    UITextField *userCodeTF;
    UITextField *multifunctionalIntegralTF;
    UITextField *bondTF;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSMutableArray           *listArray;
@end

@implementation WJBondExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"债券兑换";
    self.isHiddenTabBar = YES;
    [self navigationSetup];
    [self UISetup];
    
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationSetup
{
    UIButton *bondRecycleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bondRecycleButton.frame = CGRectMake(0, 0, ALD(60), ALD(30));
    bondRecycleButton.titleLabel.font = WJFont14;
    [bondRecycleButton setTitle:@"债券回收" forState:UIControlStateNormal];
    [bondRecycleButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [bondRecycleButton addTarget:self action:@selector(bondRecycleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bondRecycleButton];
    
}

-(void)UISetup
{
    UIButton *bondExchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bondExchangeButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [bondExchangeButton setTitle:@"兑换债券" forState:UIControlStateNormal];
    bondExchangeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bondExchangeButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    bondExchangeButton.backgroundColor = WJColorMainColor;
    bondExchangeButton.titleLabel.font = WJFont14;
    
    [bondExchangeButton addTarget:self action:@selector(bondExchangeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bondExchangeButton];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(214);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = WJColorMainColor;
    

    UILabel *bondL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(30), ALD(50), ALD(20))];
    bondL.text = @"债券";
    bondL.textColor = WJColorWhite;
    bondL.font = WJFont12;
    
    UILabel *countL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), bondL.bottom + ALD(23), kScreenWidth - ALD(24), ALD(20))];
    countL.text = @"3000张";
    countL.textColor = WJColorWhite;
    countL.textAlignment = NSTextAlignmentLeft;
    countL.font = WJFont45;

    [headerView addSubview:bondL];
    [headerView addSubview:countL];

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bondExchangeCellWithIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bondExchangeCellWithIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        
        
        UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.tag = 1001;
        
        
        UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), 0, ALD(200), ALD(44))];
        contentTF.font = WJFont14;
        contentTF.textColor = WJColorDarkGray;
        contentTF.keyboardType = UIKeyboardTypeNumberPad;
        contentTF.textAlignment = NSTextAlignmentRight;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        contentTF.delegate = self;
        contentTF.tag = 1002;
        
        [cell.contentView addSubview:nameL];
        [cell.contentView addSubview:contentTF];
        
        
    }
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:1001];
    UITextField *contentTF = (UITextField *)[cell.contentView viewWithTag:1002];

    
    NSDictionary *dic = self.listArray[indexPath.row];
    nameL.text = dic[@"text"];
    
    if (indexPath.row == 0) {
        
        contentTF.userInteractionEnabled = NO;
        contentTF.text = @"A888888";
        userCodeTF = contentTF;
        
    } else if (indexPath.row == 1) {
        
        contentTF.userInteractionEnabled = YES;
        contentTF.placeholder = @"请输入多功能积分";
        multifunctionalIntegralTF = contentTF;

    } else {
        
        contentTF.userInteractionEnabled = NO;
        bondTF = contentTF;
        contentTF.text = [NSString stringWithFormat:@"%ld",[multifunctionalIntegralTF.text integerValue] / 5];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - Action
-(void)bondRecycleButtonAction
{
    WJBondRecycleViewController *bondRecycleVC = [[WJBondRecycleViewController alloc] init];
    [self.navigationController pushViewController:bondRecycleVC animated:YES];
}


-(void)bondExchangeButtonAction
{
    if (!(multifunctionalIntegralTF.text.length > 0)) {
        ALERT(@"请输入多功能积分");
        return;
    }
    
    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"债券兑换" message:@"是否确认使用多功能积分兑换债券" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
    [alertView showIn];
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        
    }
}

#pragma mark - event
-(void)handletapPressGesture
{
    [userCodeTF resignFirstResponder];
    [multifunctionalIntegralTF resignFirstResponder];
    [bondTF resignFirstResponder];
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(NSArray *)listArray
{
    return @[
             @{@"text":@"用户编号"},
             @{@"text":@"多功能积分"},
             @{@"text":@"债券"}
             ];
}


@end
