//
//  WJRechargeRedIntegralViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRechargeRedIntegralViewController.h"
#import "WJRechargeCenterCell.h"
#import "APIIntegralRechargeManager.h"
#import "AlipayManager.h"
#import "WeixinPayManager.h"
@interface WJRechargeRedIntegralViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,APIManagerCallBackDelegate>
{
    UITextField *amountTF;
}
@property(nonatomic,strong)APIIntegralRechargeManager *integralRechargeManager;
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSArray                  *listArray;
@property(nonatomic,assign)NSInteger                selectPayAwayIndex;
@end

@implementation WJRechargeRedIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值红积分";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    [self UISetup];
    
}

-(void)UISetup
{
    UIButton *payRightNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payRightNowButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [payRightNowButton setTitle:@"支付" forState:UIControlStateNormal];
    payRightNowButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [payRightNowButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    payRightNowButton.backgroundColor = WJColorMainColor;
    payRightNowButton.layer.cornerRadius = 4;
    payRightNowButton.layer.masksToBounds = YES;
    payRightNowButton.titleLabel.font = WJFont14;
    
    [payRightNowButton addTarget:self action:@selector(payRightNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:payRightNowButton];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIIntegralRechargeManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        if ([self.integralRechargeManager.payType isEqualToString:@"1"]) {
            
            [[AlipayManager alipayManager]callAlipayWithOrderString:dic[@"prepayid"] NowController:self TotleCash:dic[@"order_total"]];
            
        } else if ([self.integralRechargeManager.payType isEqualToString:@"2"]){
            
            [[WeixinPayManager WXPayManager]callWexinPayWithPrePayid:dic[@"prepayid"]NowController:self TotleCash:dic[@"order_total"]];
        }
    }

}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
        
    }  else {
        return 2;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPaymentIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectPaymentIdentifier"];
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
            UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
            nameL.textColor = WJColorDarkGray;
            nameL.font = WJFont14;
            
            
            UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), 0, ALD(200), ALD(44))];
            contentTF.font = WJFont14;
            contentTF.textColor = WJColorDarkGray;
            contentTF.keyboardType = UIKeyboardTypeNumberPad;
            contentTF.textAlignment = NSTextAlignmentRight;
            contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            contentTF.delegate = self;
            [cell.contentView addSubview:contentTF];
            
            [cell.contentView addSubview:nameL];
            [cell.contentView addSubview:contentTF];
            
            NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];

            
            NSDictionary *dic = self.listArray[indexPath.row];
            nameL.text = dic[@"text"];
            
            if (indexPath.row == 0) {
                
                contentTF.userInteractionEnabled = NO;
                contentTF.text = infoDic[@"userCode"];
                
            } else {
                
                contentTF.userInteractionEnabled = YES;
                contentTF.placeholder = @"请输入金额";
                amountTF = contentTF;
            }
            
        }
            break;
            
        case 1:
        {
            WJRechargeCenterCell *rechargeCenterCell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
            rechargeCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell  = rechargeCenterCell;
            
            if (indexPath.row == 0) {
                
                rechargeCenterCell.textLabel.text = @"支付宝支付";
                
                if (indexPath.row == self.selectPayAwayIndex) {
                    [rechargeCenterCell conFigData:YES];
                }else{
                    [rechargeCenterCell conFigData:NO];
                }
                
                
            } else {
                
                rechargeCenterCell.textLabel.text = @"微信支付";
                
                if (indexPath.row == self.selectPayAwayIndex) {
                    [rechargeCenterCell conFigData:YES];
                }else{
                    [rechargeCenterCell conFigData:NO];
                }
                
            }
        }
            
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        self.selectPayAwayIndex = indexPath.row;
        [self.tableView reloadData];
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [amountTF resignFirstResponder];
    return YES;
}

#pragma mark - Action
-(void)payRightNowButtonAction
{
    if (!(amountTF.text.length > 0)) {
        ALERT(@"请输入金额");
        return;
    }
    
    switch (self.selectPayAwayIndex) {
        case 0:
        {
            //支付宝
            self.integralRechargeManager.payType = @"1";

        }
            break;
            
        case 1:
        {
            //微信
            self.integralRechargeManager.payType = @"2";
        }
            break;
            
        default:
            break;
    }
    self.integralRechargeManager.rechargeAmount = amountTF.text;
    [self.integralRechargeManager loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain];
        
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
             @{@"text":@"用户编号"},
             @{@"text":@"金额"}
             ];
}

-(APIIntegralRechargeManager *)integralRechargeManager
{
    if (!_integralRechargeManager) {
        _integralRechargeManager = [[APIIntegralRechargeManager alloc] init];
        _integralRechargeManager.delegate = self;
    }
    _integralRechargeManager.integralType = @"2";

    return _integralRechargeManager;
}

@end
