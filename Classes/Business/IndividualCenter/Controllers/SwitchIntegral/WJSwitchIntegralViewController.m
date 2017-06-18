//
//  WJSwitchIntegralViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSwitchIntegralViewController.h"
#import "WJRechargeCenterCell.h"
#import "APISwitchIntegralManager.h"
#import "APIRecommenderInfoManager.h"
@interface WJSwitchIntegralViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField *userCodeTF;
    UITextField *switchIntegralTF;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSArray                  *listArray;
@property(nonatomic,assign)NSInteger                selectPayAwayIndex;
@property(nonatomic,strong)APISwitchIntegralManager *switchIntegralManager;
@property(nonatomic,strong)APIRecommenderInfoManager *recommendInfoManager;
@property(nonatomic,strong)NSString                  *recommendName;
@property(nonatomic,strong)NSString                  *contact;

@end

@implementation WJSwitchIntegralViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转积分";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
    [self UISetup];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
}

-(void)UISetup
{
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [confirmButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    confirmButton.backgroundColor = WJColorMainColor;
    confirmButton.layer.cornerRadius = 4;
    confirmButton.layer.masksToBounds = YES;
    confirmButton.titleLabel.font = WJFont14;
    
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmButton];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIRecommenderInfoManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        self.recommendName = dic[@"userName"];
        self.contact = dic[@"contact"];
        
        NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:1 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:2 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath2,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        
    } else if([manager isKindOfClass:[APISwitchIntegralManager class]]) {
        
        ALERT(@"转积分成功");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == userCodeTF) {
        [self.recommendInfoManager loadData];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.recommendInfoManager loadData];
    [self handletapPressGesture];
    return YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
        
    }  else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return ALD(10);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchIntegralCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SwitchIntegralCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    switch (indexPath.section) {
            
        case 0:
        {
            WJRechargeCenterCell *rechargeCenterCell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
            rechargeCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell  = rechargeCenterCell;
            
            rechargeCenterCell.textLabel.text = @"可用积分";

            if (indexPath.row == self.selectPayAwayIndex) {
                [rechargeCenterCell conFigData:YES];
            } else {
                [rechargeCenterCell conFigData:NO];
            }
   
        }
            
            break;
            
        case 1:
        {
            UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(100), ALD(22))];
            nameL.textColor = WJColorDarkGray;
            nameL.font = WJFont14;
            
            
            UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), 0, ALD(200), ALD(44))];
            contentTF.font = WJFont14;
            contentTF.textColor = WJColorDarkGray;
            contentTF.delegate = self;
            contentTF.textAlignment = NSTextAlignmentRight;
            
            [cell.contentView addSubview:nameL];
            [cell.contentView addSubview:contentTF];
            
            
            NSDictionary *dic = self.listArray[indexPath.row];
            nameL.text = dic[@"text"];
            
            if (indexPath.row == 0) {
                
                contentTF.placeholder = @"请输入对方用户编号";
                contentTF.userInteractionEnabled = YES;
                userCodeTF = contentTF;
                
            } else if (indexPath.row == 1) {
                
                contentTF.userInteractionEnabled = NO;
                
                if (self.recommendName) {
                    contentTF.text = self.recommendName;
                } else {
                    contentTF.text = @"";

                }
                
            } else if (indexPath.row == 2) {
                
                contentTF.userInteractionEnabled = NO;
                if (self.contact) {
                    contentTF.text = self.contact;
                } else {
                    
                    contentTF.text = @"";
                }

            }  else {
                
                contentTF.placeholder = @"请输入转积分";
                contentTF.userInteractionEnabled = YES;
                switchIntegralTF = contentTF;

            }
            
        }
            break;

        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        self.selectPayAwayIndex = indexPath.row;
        [self.tableView reloadData];
    }
}

#pragma mark - Action
-(void)confirmButtonAction
{
    if (!(userCodeTF.text.length > 0)) {
        ALERT(@"请输入对方用户编号");
        return;
    }
    if (!(switchIntegralTF.text.length > 0)) {
        ALERT(@"请输入转积分");
        return;
    }
    [self.switchIntegralManager loadData];
}

#pragma mark - event
-(void)handletapPressGesture
{
    [userCodeTF resignFirstResponder];
    [switchIntegralTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(NSArray *)listArray
{
    return @[
             @{@"text":@"对方用户编号"},
             @{@"text":@"用户名"},
             @{@"text":@"手机号"},
             @{@"text":@"转积分"}
             ];
}

-(APISwitchIntegralManager *)switchIntegralManager
{
    if (!_switchIntegralManager) {
        _switchIntegralManager = [[APISwitchIntegralManager alloc] init];
        _switchIntegralManager.delegate = self;
    }
    _switchIntegralManager.inUserId = userCodeTF.text;
    _switchIntegralManager.integral = switchIntegralTF.text;

    return _switchIntegralManager;
}


-(APIRecommenderInfoManager *)recommendInfoManager
{
    if (!_recommendInfoManager) {
        _recommendInfoManager = [[APIRecommenderInfoManager alloc] init];
        _recommendInfoManager.delegate = self;
    }
    _recommendInfoManager.recommenderCode = userCodeTF.text;
    return _recommendInfoManager;
}
@end
