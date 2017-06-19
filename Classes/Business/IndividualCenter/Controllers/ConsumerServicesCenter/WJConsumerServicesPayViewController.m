//
//  WJConsumerServicesPayViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerServicesPayViewController.h"
#import "WJRechargeCenterCell.h"

#import "WJConsumerServicesIntegralViewController.h"
#import "APIServiceCenterConditionManager.h"
#import "WJServiceCenterConditionModel.h"
#import "APIOpenServiceCenterManager.h"
#import "WJAddressViewController.h"
#import "AlipayManager.h"
#import "WeixinPayManager.h"

@interface WJConsumerServicesPayViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    UIButton *payRightNowButton;
}
@property(nonatomic,strong)APIServiceCenterConditionManager *conditionManager;
@property(nonatomic,strong)APIOpenServiceCenterManager      *openServiceCenterManager;
@property(nonatomic,strong)WJServiceCenterConditionModel    *conditionModel;
@property(nonatomic,strong)UITableView                      *tableView;
@property(nonatomic,strong)NSArray                          *listArray;
@property(nonatomic,assign)NSInteger                        selectPayAwayIndex;
@end

@implementation WJConsumerServicesPayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费服务中心";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
    [self UISetup];
    [self.conditionManager loadData];
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

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIServiceCenterConditionManager class]])
    {
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        self.conditionModel = [[WJServiceCenterConditionModel alloc] initWithDic:dic];
        [self.tableView reloadData];
        

    } else if ([manager isKindOfClass:[APIOpenServiceCenterManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        if ([self.openServiceCenterManager.payType isEqualToString:@"1"]) {
            
            [[AlipayManager alipayManager]callAlipayWithOrderString:dic[@"prepayid"] NowController:self TotleCash:dic[@"order_total"]];
            
        }else if ([self.openServiceCenterManager.payType isEqualToString:@"2"]){
     
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
        return 7;
        
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
    
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    
    switch (indexPath.section) {
        case 0:
        {
            UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
            nameL.textColor = WJColorDarkGray;
            nameL.font = WJFont14;
            
            
            UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), 0, ALD(200), ALD(44))];
            contentL.font = WJFont14;
            contentL.textColor = WJColorDarkGray;
            contentL.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:contentL];
            
            [cell.contentView addSubview:nameL];
            [cell.contentView addSubview:contentL];
            
            
            NSDictionary *dic = self.listArray[indexPath.row];
            nameL.text = dic[@"text"];
            
            if (indexPath.row == 0) {
                
                UIImage *image = [UIImage imageNamed:@"icon_arrow_right"];
                UIImageView *rightArrowIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - image.size.width,(ALD(44) - image.size.height)/2, image.size.width, image.size.height)];
                rightArrowIV.image = image;
                [cell.contentView addSubview:rightArrowIV];
                
                
            } else if (indexPath.row == 1) {
                
                contentL.text  =  infoDic[@"userCode"];

                
            } else if (indexPath.row == 2) {
                
                contentL.text  =  infoDic[@"name"];
                
            }  else if (indexPath.row == 3) {
                contentL.text = infoDic[@"contact"];
                
            }  else if (indexPath.row == 4) {
                contentL.text = [NSString stringWithFormat:@"%@元",self.conditionModel.amount];
                
            }  else if (indexPath.row == 5) {
                contentL.text = [NSString stringWithFormat:@"%@/%@积分",self.conditionModel.freezeIntegral,self.conditionModel.integralStandard];
                
            } else {
                
                contentL.text = [NSString stringWithFormat:@"%@/%@人 >= %@待用积分",self.conditionModel.member,self.conditionModel.memberStandard,self.conditionModel.memberIntegralStandard];
            }
            
            
        }
            break;
            
        case 1:
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
        
        if (indexPath.row == 0) {
            
            WJAddressViewController *addressVC = [[WJAddressViewController alloc]init];
            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:addressVC];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
        
    } else {
        
        self.selectPayAwayIndex = indexPath.row;
        [self.tableView reloadData];
        
    }
}

#pragma mark - Action
-(void)payRightNowButtonAction
{
    switch (self.selectPayAwayIndex) {
        case 0:
        {
            //支付宝
            self.openServiceCenterManager.payType = @"1";
            
        }
            break;
            
        case 1:
        {
            //微信
            self.openServiceCenterManager.payType = @"2";

        }
            break;
            
        default:
            break;
    }
    
    self.openServiceCenterManager.payAmount = self.conditionModel.amount;
    [self.openServiceCenterManager loadData];
    
//    WJConsumerServicesIntegralViewController *consumerServicesIntegralVC = [[WJConsumerServicesIntegralViewController alloc] init];
//    [self.navigationController pushViewController:consumerServicesIntegralVC animated:YES];
    
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
             @{@"text":@"选择大区"},
             @{@"text":@"用户编号"},
             @{@"text":@"真实姓名"},
             @{@"text":@"联系方式"},
             @{@"text":@"金额"},
             @{@"text":@"待用积分"},
             @{@"text":@"直推会员"}
             ];
}


-(APIServiceCenterConditionManager *)conditionManager
{
    if (!_conditionManager) {
        _conditionManager = [[APIServiceCenterConditionManager alloc] init];
        _conditionManager.delegate = self;
    }
    return _conditionManager;
}

-(APIOpenServiceCenterManager *)openServiceCenterManager
{
    if (!_openServiceCenterManager) {
        _openServiceCenterManager = [[APIOpenServiceCenterManager alloc] init];
        _openServiceCenterManager.delegate = self;
    }
    return _openServiceCenterManager;
}

@end
