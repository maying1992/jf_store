//
//  WJRefundOrderDetailViewController.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRefundOrderDetailViewController.h"
#import "WJPurchaseOrderDetailCell.h"
#import "WJProductModel.h"
#import "WJApplyRefundViewController.h"
#import "WJLogisticsDetailViewController.h"
#import "WJOnLinePayViewController.h"
#import "WJPassView.h"
#import "WJSystemAlertView.h"
#import "WJIntegralTradePasswordViewController.h"
#import "APIOrderDetailManager.h"
#import "WJOrderDetailModel.h"
#import "WJOrderDetailReformer.h"
#import "WJShopModel.h"
@interface WJRefundOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource,WJPassViewDelegate,WJSystemAlertViewDelegate>
{
    UIView      *bottomView;
    UILabel     *totalAmountL;
}
@property(nonatomic,strong)UITableView                  *tableView;
@property(nonatomic,strong)APIOrderDetailManager        *orderDetailManager;
@property(nonatomic,strong)WJOrderDetailModel           *detailModel;
@end

@implementation WJRefundOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.isHiddenTabBar = YES;
    
    [self initBottomView];
    [self.view addSubview:self.tableView];
    [self.orderDetailManager loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBottomView
{
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavigationBarHeight - ALD(64), kScreenWidth, ALD(64))];
    
    bottomView.backgroundColor = WJColorWhite;
    bottomView.layer.borderWidth = 0.5f;
    bottomView.layer.borderColor =  WJColorSeparatorLine.CGColor;
    
    totalAmountL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), kScreenWidth - ALD(12) - ALD(160) - ALD(24), ALD(30))];
    totalAmountL.font = WJFont13;
    totalAmountL.textAlignment = NSTextAlignmentLeft;
    
    //    NSString *totalAmountStr = [NSString stringWithFormat:@"合计: %@元%@积分",self.detailModel.totalMoney,self.detailModel.totalIntegral];
    //    totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
    [bottomView addSubview:totalAmountL];
    
    if (self.orderModel.orderStatus == OrderStatusUnfinished) {
        
        UIButton *payRigthNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        payRigthNowButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [payRigthNowButton setTitle:@"付款"
                           forState:UIControlStateNormal];
        [payRigthNowButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        payRigthNowButton.titleLabel.font = WJFont14;
        payRigthNowButton.backgroundColor = WJColorMainColor;
        payRigthNowButton.layer.cornerRadius = 4;
        [payRigthNowButton addTarget:self action:@selector(payRigthNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:payRigthNowButton];
        
        
    } else if (self.orderModel.orderStatus == OrderStatusClose) {
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [deleteButton setTitle:@"删除"
                      forState:UIControlStateNormal];
        [deleteButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        deleteButton.titleLabel.font = WJFont14;
        deleteButton.backgroundColor = WJColorMainColor;
        deleteButton.layer.cornerRadius = 4;
        [deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:deleteButton];
        
    } else if (self.orderModel.orderStatus == OrderStatusSuccess) {
        
        UIButton *logisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        logisticsButton.frame = CGRectMake(bottomView.width - ALD(20) - ALD(160), ALD(10), ALD(80), ALD(30));
        [logisticsButton setTitle:@"查看物流"
                         forState:UIControlStateNormal];
        [logisticsButton setTitleColor:WJColorBlack forState:UIControlStateNormal];
        logisticsButton.layer.cornerRadius = 4;
        logisticsButton.layer.borderColor = WJColorBlack.CGColor;
        logisticsButton.layer.borderWidth = 0.5f;
        logisticsButton.titleLabel.font = WJFont14;
        [logisticsButton addTarget:self action:@selector(logisticsButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:logisticsButton];
        
        UIButton *buyAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyAgainButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [buyAgainButton setTitle:@"再次购买"
                        forState:UIControlStateNormal];
        [buyAgainButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        buyAgainButton.layer.cornerRadius = 4;
        buyAgainButton.backgroundColor = WJColorMainColor;
        buyAgainButton.titleLabel.font = WJFont14;
        [buyAgainButton addTarget:self action:@selector(buyAgainButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:buyAgainButton];
        
        
    } else if (self.orderModel.orderStatus == OrderStatusWaitReceive) {
        
        UIButton *logisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        logisticsButton.frame = CGRectMake(bottomView.width - ALD(20) - ALD(160), ALD(10), ALD(80), ALD(30));
        [logisticsButton setTitle:@"查看物流"
                         forState:UIControlStateNormal];
        [logisticsButton setTitleColor:WJColorBlack forState:UIControlStateNormal];
        logisticsButton.layer.cornerRadius = 4;
        logisticsButton.layer.borderColor = WJColorBlack.CGColor;
        logisticsButton.layer.borderWidth = 0.5f;
        logisticsButton.titleLabel.font = WJFont14;
        [logisticsButton addTarget:self action:@selector(logisticsButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:logisticsButton];
        
        
        UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        finishButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [finishButton setTitle:@"完成"
                      forState:UIControlStateNormal];
        [finishButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        finishButton.backgroundColor = WJColorMainColor;
        finishButton.titleLabel.font = WJFont14;
        finishButton.layer.cornerRadius = 4;
        [finishButton addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:finishButton];
        
    } else if (self.orderModel.orderStatus == OrderStatusWaitDeliver) {
        
        UIButton *refundOnlyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        refundOnlyButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [refundOnlyButton setTitle:@"退款"
                          forState:UIControlStateNormal];
        [refundOnlyButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        refundOnlyButton.backgroundColor = WJColorMainColor;
        refundOnlyButton.titleLabel.font = WJFont14;
        refundOnlyButton.layer.cornerRadius = 4;
        [refundOnlyButton addTarget:self action:@selector(refundOnlyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:refundOnlyButton];
        
    }  else if (self.orderModel.orderStatus == OrderStatusApplyRefund) {
        
        UIButton *cancelRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelRefundButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [cancelRefundButton setTitle:@"取消退款"
                            forState:UIControlStateNormal];
        [cancelRefundButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        cancelRefundButton.backgroundColor = WJColorMainColor;
        cancelRefundButton.titleLabel.font = WJFont14;
        cancelRefundButton.layer.cornerRadius = 4;
        [cancelRefundButton addTarget:self action:@selector(cancelRefundButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:cancelRefundButton];
        
    } else if (self.orderModel.orderStatus == OrderStatusRefunding) {
        
        bottomView.hidden = YES;
        
    } else if (self.orderModel.orderStatus == OrderStatusAlreadyRefund) {
        
        NSString *totalAmountStr = [NSString stringWithFormat:@"退款: %@",@"4324"];
        totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
        
    } else if (self.orderModel.orderStatus == OrderStatusRefuseRefund) {
        
        bottomView.hidden = YES;
    }
    
    
    [self.view addSubview:bottomView];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIOrderDetailManager class]]) {
        
        self.detailModel = [manager fetchDataWithReformer:[[WJOrderDetailReformer alloc] init]];
        
        [self.tableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2 + self.detailModel.shopList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == self.detailModel.shopList.count) {
        return 2;
    } else if (section == self.detailModel.shopList.count + 1) {
        return 1;
    } else {
        
        WJShopModel *shopModel = self.detailModel.shopList[section - 1];
        if (shopModel.productList == nil || shopModel.productList.count == 0) {
            return 0;
            
        } else {
            return shopModel.productList.count;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.detailModel.shopList.count) {
        return 0;
        
    } else if (section == self.detailModel.shopList.count + 1) {
        return 0;
    } else {
        return ALD(40);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.detailModel.shopList.count) {
        return ALD(10);
        
    } else if (section == self.detailModel.shopList.count + 1) {
        return ALD(10);
    } else {
        return ALD(55);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    
    if (section < self.detailModel.shopList.count) {
        
        headerView.backgroundColor = WJColorWhite;
        
        UILabel *shopNameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), ALD(200), ALD(20))];
        shopNameL.textColor = WJColorDarkGray;
        shopNameL.font = WJFont12;
        shopNameL.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:shopNameL];
        
        UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(10) - ALD(100), ALD(10), ALD(100), ALD(30))];
        statusL.textColor = WJColorDardGray3;
        statusL.font = WJFont12;
        statusL.textAlignment = NSTextAlignmentRight;
        [headerView addSubview:statusL];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), ALD(40) - 0.5, kScreenWidth - ALD(24), 0.5)];
        line.backgroundColor = WJColorSeparatorLine;
        [headerView addSubview:line];
        
        
        shopNameL.text = self.orderModel.shopName;
        
        switch (self.orderModel.orderStatus) {
            case OrderStatusSuccess:
            {
                statusL.text = @"完成";
            }
                break;
                
            case OrderStatusUnfinished:
            {
                statusL.text = @"未支付";
            }
                break;
                
            case OrderStatusClose:
            {
                statusL.text = @"取消订单";
            }
                break;
                
            case OrderStatusWaitDeliver:
            {
                statusL.text = @"待发货";
            }
                break;
                
            case OrderStatusWaitReceive:
            {
                statusL.text = @"待收货";
            }
                break;
                
            case OrderStatusRefunding:
            {
                statusL.text = @"退款中";
            }
                break;
                
            case OrderStatusAlreadyRefund:
            {
                statusL.text = @"退款成功";
            }
                break;
                
            default:
                break;
        }
        
    }
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    
    if (section < self.detailModel.shopList.count) {
        
        footerView.backgroundColor = WJColorWhite;
        
        UILabel *totalMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), 0, ALD(150), ALD(30))];
        totalMoneyL.textAlignment = NSTextAlignmentRight;
        [footerView addSubview:totalMoneyL];
        
        
        NSString *totalMoneyStr = [NSString stringWithFormat:@"商品小计: %@",self.orderModel.PayAmount];
        totalMoneyL.attributedText= [self attributedText:totalMoneyStr firstLength:5];
        
        
        UILabel *freightL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), totalMoneyL.bottom, ALD(150), ALD(30))];
        freightL.textAlignment = NSTextAlignmentRight;
        [footerView addSubview:freightL];
        
        
        NSString *freightStr = [NSString stringWithFormat:@"运费: %@",self.orderModel.freight];
        freightL.attributedText= [self attributedText:freightStr firstLength:3];
        
        return footerView;
    }
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    if (section == self.detailModel.shopList.count) {
        return ALD(44);
        
    } else if (section == self.detailModel.shopList.count + 1) {
        return ALD(150);
    } else {
        return ALD(130);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    NSInteger section = indexPath.section;
    
    if (section == self.detailModel.shopList.count) {
   
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(60), ALD(44))];
        nameL.font = WJFont12;
        nameL.textColor = WJColorDardGray3;
        nameL.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:nameL];
        
        UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), 0, ALD(150), ALD(44))];
        contentL.font = WJFont12;
        contentL.textColor = WJColorDardGray3;
        contentL.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentL];
        
        if (indexPath.row == 0) {
            nameL.text = @"退款原因";
            contentL.text = @"买重复了";
            
        } else {
            
            nameL.text = @"退款说明";
            contentL.text = @"商品购买重复申请，谢谢";
        }
        
    } else if (section == self.detailModel.shopList.count + 1) {
        
        
        UILabel *orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(15), ALD(200), ALD(20))];
        orderNoL.textColor = WJColorDardGray3;
        orderNoL.text = [NSString stringWithFormat:@"订单编号：%@",self.orderModel.orderNo];
        orderNoL.font = WJFont12;
        orderNoL.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:orderNoL];
        
        
        UILabel *orderTimeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), orderNoL.bottom, ALD(200), ALD(20))];
        orderTimeL.text = [NSString stringWithFormat:@"提交时间：%@",self.detailModel.submitTime];
        orderTimeL.textColor = WJColorDardGray3;
        orderTimeL.font = WJFont12;
        orderTimeL.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:orderTimeL];
        
        UILabel *payTimeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), orderTimeL.bottom, ALD(200), ALD(20))];
        payTimeL.text = [NSString stringWithFormat:@"支付时间：%@",self.detailModel.payTime];
        payTimeL.textColor = WJColorDardGray3;
        payTimeL.font = WJFont12;
        payTimeL.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:payTimeL];

        
        
    } else {
        
        WJPurchaseOrderDetailCell *purchaseCell = [[WJPurchaseOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
        purchaseCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell  = purchaseCell;
        
        WJShopModel *shop = self.detailModel.shopList[indexPath.section - 1];
        [purchaseCell configDataWithProduct:shop.productList[indexPath.row]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - WJPassViewDelegate
- (void)successWithVerifyPsdAlert:(WJPassView *)alertView
{
    switch (self.orderModel.payType) {
            
        case 3:
        {
            //积分支付
            NSLog(@"支付成功");
            
        }
            break;
            
        case 4:
        {
            //积分+微信
            WJOnLinePayViewController *onLinePayVC = [[WJOnLinePayViewController alloc] init];
            onLinePayVC.orderModel = self.orderModel;
            [self.navigationController pushViewController:onLinePayVC animated:YES];
            
        }
            break;
            
        case 5:
        {
            //积分+支付宝
            WJOnLinePayViewController *onLinePayVC = [[WJOnLinePayViewController alloc] init];
            onLinePayVC.orderModel = self.orderModel;
            [self.navigationController pushViewController:onLinePayVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)failedWithVerifyPsdAlert:(WJPassView *)alertView errerMessage:(NSString * )errerMessage
{
    [alertView dismiss];
    
    [self showAlertWithMessage:errerMessage];
    
}

-(void)setTradePasswordActionWith:(WJPassView *)alertView
{
    [alertView dismiss];
    
    WJIntegralTradePasswordViewController *integralTradePasswordViewController = [[WJIntegralTradePasswordViewController alloc] init];
    [self.navigationController pushViewController:integralTradePasswordViewController animated:YES];
}

- (void)forgetPasswordActionWith:(WJPassView *)alertView
{
    [alertView dismiss];
    
    WJIntegralTradePasswordViewController *integralTradePasswordViewController = [[WJIntegralTradePasswordViewController alloc] init];
    [self.navigationController pushViewController:integralTradePasswordViewController animated:YES];}

#pragma mark - WJSystemAlertViewDelegate
- (void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //取消
    if (buttonIndex == 0) {
        [alertView dismiss];
        
    } else {
        
        WJPassView *passView = [[WJPassView alloc] initWithFrame:self.view.bounds title:@"请输入支付密码"];
        passView.delegate = self;
        [passView showIn];
    }
}



- (void)showAlertWithMessage:(NSString *)msg
{
    WJSystemAlertView *sysAlert = [[WJSystemAlertView alloc] initWithTitle:@"验证失败" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再试一次" textAlignment:NSTextAlignmentCenter];
    
    [sysAlert showIn];
}


#pragma mark - Action
-(void)payRigthNowButtonAction
{
    NSLog(@"付款");
    
    switch (self.orderModel.payType) {
        case 1:
        {
            //微信支付
            WJOnLinePayViewController *onLinePayVC = [[WJOnLinePayViewController alloc] init];
            onLinePayVC.orderModel = self.orderModel;
            [self.navigationController pushViewController:onLinePayVC animated:YES];
            
        }
            break;
            
        case 2:
        {
            //支付宝支付
            WJOnLinePayViewController *onLinePayVC = [[WJOnLinePayViewController alloc] init];
            onLinePayVC.orderModel = self.orderModel;
            [self.navigationController pushViewController:onLinePayVC animated:YES];
            
        }
            break;
            
        case 3:
        {
            //积分支付
            WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
            passView.delegate = self;
            [passView showIn];
            
            
        }
            break;
            
        case 4:
        {
            //积分+微信
            WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
            passView.delegate = self;
            [passView showIn];
            
            
        }
            break;
            
        case 5:
        {
            //积分+支付宝
            WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
            passView.delegate = self;
            [passView showIn];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)deleteButtonAction
{
    
}

-(void)logisticsButtonAction
{
    WJLogisticsDetailViewController *logisticsDetailVC = [[WJLogisticsDetailViewController alloc] init];
    [self.navigationController pushViewController:logisticsDetailVC animated:YES];
}

-(void)buyAgainButtonAction
{
    
}

-(void)finishButtonAction
{
    
}

-(void)refundOnlyButtonAction
{
    WJApplyRefundViewController *applyRefundVC = [[WJApplyRefundViewController alloc] init];
    [self.navigationController pushViewController:applyRefundVC animated:YES];
}

-(void)cancelRefundButtonAction
{
    
}

- (NSAttributedString *)attributedText:(NSString *)text firstLength:(NSInteger)len{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    NSDictionary *attributesForFirstWord = @{
                                             NSFontAttributeName : WJFont12,
                                             NSForegroundColorAttributeName : WJColorDarkGray,
                                             };
    
    NSDictionary *attributesForSecondWord = @{
                                              NSFontAttributeName : WJFont12,
                                              NSForegroundColorAttributeName : WJColorSubColor,
                                              };
    [result setAttributes:attributesForFirstWord
                    range:NSMakeRange(0, len)];
    [result setAttributes:attributesForSecondWord
                    range:NSMakeRange(len, text.length - len)];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:result];
}


#pragma mark - setter& getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - ALD(64)) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(-ALD(40), 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(APIOrderDetailManager *)orderDetailManager
{
    if (!_orderDetailManager) {
        _orderDetailManager = [[APIOrderDetailManager alloc] init];
        _orderDetailManager.delegate = self;
    }
    _orderDetailManager.orderId = self.orderModel.orderId;
    return _orderDetailManager;
}

@end
