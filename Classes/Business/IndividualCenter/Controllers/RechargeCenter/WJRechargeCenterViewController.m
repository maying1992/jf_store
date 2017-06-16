//
//  WJRechargeCenterViewController.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRechargeCenterViewController.h"
#import "WJRechargeCenterCell.h"
@interface WJRechargeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *payRightNowButton;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSMutableArray           *payArray;
@property(nonatomic,assign)NSInteger                selectPayAwayIndex;
@property(nonatomic,assign)NSInteger                selectRechargeTypeIndex;

@end

@implementation WJRechargeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值中心";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
//    NSArray *paymentArray = [self.paymentModel.payMentType componentsSeparatedByString:@","];
//    
//    for (id object in paymentArray) {
//        
//        NSInteger payIndex = (NSInteger)[object integerValue];
//        
//        if (payIndex == 1) {
//            
//            [_payArray addObject:@{@"text":@"支付宝支付",@"away":@"alipay"}];
//            
//        } else if (payIndex == 2) {
//            
//            [_payArray addObject:@{@"text":@"微信支付",@"away":@"weixin"}];
//            
//        }
//    }
    
    [self UISetup];
}

-(void)UISetup
{
    payRightNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
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

//#pragma mark - APIManagerCallBackDelegate
//- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
//{
//    if ([manager isKindOfClass:[APIPayMentManager class]]) {
//        NSDictionary *dic = [manager fetchDataWithReformer:nil];
//        if ([self.payMentManager.payType isEqualToString:@"1"]) {
//            [AlipayManager alipayManager].selectPaymentVC = self;
//            [AlipayManager alipayManager].totleCash = dic[@"order_total"];
//            [[AlipayManager alipayManager]callAlipayWithOrderString:dic[@"prepayid"]];
//        }else if ([self.payMentManager.payType isEqualToString:@"2"]){
//            [WeixinPayManager WXPayManager].selectPaymentVC = self;
//            [WeixinPayManager WXPayManager].totleCash = dic[@"order_total"];
//            [[WeixinPayManager WXPayManager]callWexinPayWithPrePayid:dic[@"prepayid"]];
//        }
//    }
//}
//
//- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
//{
//    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
//}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        
        return 4;
    } else {
//        return self.payArray.count;
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
            WJRechargeCenterCell *rechargeCenterCell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
            rechargeCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell  = rechargeCenterCell;
            
            if (indexPath.row == 0) {
                
                rechargeCenterCell.textLabel.text = @"分享积分充值";
                
                if (indexPath.row == self.selectRechargeTypeIndex) {
                    [rechargeCenterCell conFigData:YES];
                } else {
                    [rechargeCenterCell conFigData:NO];
                }
                
                
            } else {
                
                rechargeCenterCell.textLabel.text = @"可用积分充值";
                
                if (indexPath.row == self.selectRechargeTypeIndex) {
                    [rechargeCenterCell conFigData:YES];
                } else {
                    [rechargeCenterCell conFigData:NO];
                }

            }
            
           
        }
            break;
            
        case 1:
        {
    
            UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
            nameL.textColor = WJColorDarkGray;
            nameL.font = WJFont14;
            nameL.tag = 11000 + indexPath.row;
            
            
            UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(100), 0, ALD(100), ALD(44))];
            contentL.font = WJFont14;
            contentL.textColor = WJColorDarkGray;
            contentL.textAlignment = NSTextAlignmentRight;
            contentL.tag = 12000 + indexPath.row;
            [cell.contentView addSubview:contentL];
            
            [cell.contentView addSubview:nameL];
            [cell.contentView addSubview:contentL];
            
            if (indexPath.row == 0) {
                nameL.text = @"用户编码";
                contentL.text = @"A888888";

            } else if (indexPath.row == 1) {
                nameL.text = @"真实姓名";
                contentL.text = @"李成";

            } else if (indexPath.row == 2) {
                nameL.text = @"联系方式";
                contentL.text = @"13354283549";
                
            } else {
                nameL.text = @"金额";
                contentL.text = @"10000元";

            }
        }
            
            break;

        case 2:
        {
            WJRechargeCenterCell *rechargeCenterCell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
            rechargeCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell  = rechargeCenterCell;
            
            if (indexPath.row == 0) {
                
                rechargeCenterCell.textLabel.text = @"微信支付";
                
                if (indexPath.row == self.selectPayAwayIndex) {
                    [rechargeCenterCell conFigData:YES];
                }else{
                    [rechargeCenterCell conFigData:NO];
                }


            } else {
                
                rechargeCenterCell.textLabel.text = @"支付宝支付";
                
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
    
    if (indexPath.section == 0) {
        self.selectRechargeTypeIndex = indexPath.row;
        
    } else if (indexPath.section == 2) {
        self.selectPayAwayIndex = indexPath.row;
    }
    [self.tableView reloadData];
    
}

#pragma mark - Action
-(void)payRightNowButtonAction
{
    //调支付宝、微信支付
    switch (self.selectPayAwayIndex) {
        case 0:
        {
            //支付宝
//            self.payMentManager.payType = @"1";
        }
            break;
            
        case 1:
        {
            //微信
//            self.payMentManager.payType = @"2";
        }
            break;
            
        default:
            break;
    }
    
//    [self.payMentManager loadData];
    
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

- (NSMutableArray *)payArray
{
    if (!_payArray) {
        _payArray = [NSMutableArray array];
    }
    
    return _payArray;
}

@end
