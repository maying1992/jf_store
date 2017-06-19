//
//  WJIntegralActivateViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralActivateViewController.h"
#import "WJSystemAlertView.h"
#import "APIActivationIntegralManager.h"
#import "APIUserBindingInfoManager.h"
@interface WJIntegralActivateViewController ()<UITableViewDelegate,UITableViewDataSource,WJSystemAlertViewDelegate,UITextFieldDelegate,APIManagerCallBackDelegate>
{
    UITextField *integralTextField;
}
@property(nonatomic,strong)APIActivationIntegralManager *activationIntegralManager;
@property(nonatomic,strong)APIUserBindingInfoManager    *userBindingInfoManager;
@property(nonatomic,strong)UITableView                  *tableView;
@property(nonatomic,strong)NSArray                      *listArray;
@property(nonatomic,strong)NSString                     *serviceCode;
@end

@implementation WJIntegralActivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激活";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    [self initBottomView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
    
    [self.userBindingInfoManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBottomView
{
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth, ALD(44))];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:WJFont15];
    confirmBtn.backgroundColor = WJColorMainColor;
    [confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIUserBindingInfoManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        self.serviceCode = dic[@"service_code"];
        
        [self.tableView reloadData];
        
    } else if ([manager isKindOfClass:[APIActivationIntegralManager class]]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
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
        
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(120), ALD(44))];
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
    
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];

    
    NSDictionary *dic = self.listArray[indexPath.row];
    nameL.text = dic[@"text"];
    
    if (indexPath.row == 0) {
        
        contentTF.userInteractionEnabled = NO;
        contentTF.text = self.serviceCode ;
        
        
    } else if (indexPath.row == 1) {
        
        contentTF.text = infoDic[@"name"];
        contentTF.userInteractionEnabled = NO;

        
    } else if (indexPath.row == 2) {
        
        contentTF.userInteractionEnabled = NO;
        contentTF.text = infoDic[@"contact"];
        
    } else {
        
        contentTF.userInteractionEnabled = YES;
        contentTF.placeholder = @"请输入积分";
        integralTextField = contentTF;
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
-(void)confirmBtnAction
{
    if (!(integralTextField.text.length > 0)) {
        ALERT(@"请输入激活积分");
        return;
    }
    
    if ([integralTextField.text integerValue] > [self.doubleTotalIntegral integerValue]) {
        ALERT(@"输入超出可激活积分");
        return;
        
    }
    [self.activationIntegralManager loadData];
    
//    NSString *message = [NSString stringWithFormat:@"当前激活需红积分%@，可用积分%@是否确认激活?",@"4000",@"6000"];
//    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"激活信息" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
//    [alertView showIn];
}

#pragma mark - Action
-(void)handletapPressGesture
{
    [integralTextField resignFirstResponder];
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
             @{@"text":@"消费服务中心编码"},
             @{@"text":@"真实姓名"},
             @{@"text":@"联系方式"},
             @{@"text":@"激活积分"}
             ];
}

-(APIActivationIntegralManager *)activationIntegralManager
{
    if (!_activationIntegralManager) {
        _activationIntegralManager = [[APIActivationIntegralManager alloc] init];
        _activationIntegralManager.delegate = self;
    }
    _activationIntegralManager.integral = integralTextField.text;
    return _activationIntegralManager;
}

-(APIUserBindingInfoManager *)userBindingInfoManager
{
    if (!_userBindingInfoManager) {
        _userBindingInfoManager = [[APIUserBindingInfoManager alloc] init];
        _userBindingInfoManager.delegate = self;
    }
    return _userBindingInfoManager;
}


@end
