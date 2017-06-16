//
//  WJIndividualAllOrderController.m
//  jf_store
//
//  Created by reborn on 17/5/11.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualAllOrderController.h"
#import "WJOrderModel.h"
#import "WJPurchaseFooterView.h"
#import "WJPurchaseOrderCell.h"
#import "WJChargeOrderCell.h"
#import "WJGivingOrderCell.h"
#import "WJTradingOrderCell.h"
#import "WJRechargeOrderDetailViewController.h"
#import "WJLogisticsDetailViewController.h"
@interface WJIndividualAllOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)WJRefreshTableView  *tableView;
@property(nonatomic, strong)NSMutableArray     *orderArray;

@end

@implementation WJIndividualAllOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部订单";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.orderArray == nil || self.orderArray.count == 0) {
        return 0;
    } else {
        return self.orderArray.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    WJOrderModel *order =  self.orderArray[section];
    
    if (order.individualOrderType == OrderTypePurchase) {
        return order.productList.count;
        
    } else {
        return 1;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJOrderModel *order =  self.orderArray[indexPath.section];
    
    if (order.individualOrderType == OrderTypePurchase) {
        return ALD(130);

    } else if (order.individualOrderType == OrderTypeRecharge) {
        
        return ALD(185);

    } else if (order.individualOrderType == OrderTypeGiving) {
        
        return ALD(135);

    } else  {
        
        return ALD(185);
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    WJOrderModel *order =  self.orderArray[section];

    if (order.individualOrderType == OrderTypePurchase) {
        
        return ALD(40);
        
    } else {
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    WJOrderModel *order =  self.orderArray[section];

    if (order.individualOrderType == OrderTypePurchase) {
        
        return ALD(130);
        
    } else {
        return ALD(10);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WJOrderModel *order =  self.orderArray[section];
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = WJColorWhite;
    
    if (order.individualOrderType == OrderTypePurchase) {
        
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
        
        
        shopNameL.text = order.shopName;
        
        switch (order.orderStatus) {
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
                
            default:
                break;
        }
        
        
        return headerView;
    }
    
    return headerView;

}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WJOrderModel *order =  self.orderArray[section];

    if (order.individualOrderType == OrderTypePurchase) {
        
        static NSString *viewIdentfier = @"footerView";
        
        WJPurchaseFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
        
        if(!sectionFooterView){
            
            sectionFooterView = [[WJPurchaseFooterView alloc] initWithReuseIdentifier:viewIdentfier];
        }
        
        
        WJOrderModel *order =  self.orderArray[section];
        [sectionFooterView configDataWithOrder:order];
        
        
        __weak typeof(self) weakSelf = self;
        
        sectionFooterView.payRightNowBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            //付款
            [strongSelf purchaseOrderPayRightNowWithOrder:self.orderArray[section]];
        };
        
        sectionFooterView.cancelOrderBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            //取消订单
            [strongSelf purchaseOrderCancelOrderWithOrder:self.orderArray[section]];
        };
        
        
        sectionFooterView.checkLogisticseBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            //查看物流
            [strongSelf purchaseOrderCheckLogisticseWithOrder:self.orderArray[section]];
            
        };
        
        sectionFooterView.finishBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            //完成
            [strongSelf purchaseOrderFinishOrderWithOrder:self.orderArray[section]];
            
        };
        
        sectionFooterView.deleteOrderBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            //删除
            [strongSelf purchaseOrderDeleteOrderWithOrder:self.orderArray[section]];
        };
        
        sectionFooterView.refundBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            //退款
            [strongSelf purchaseOrderRefundWithOrder:self.orderArray[section]];
            
        };
        
        sectionFooterView.refundDetailBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            //退款详情
            [strongSelf purchaseOrderRefundDetailWithOrder:self.orderArray[section]];
        };
        
        sectionFooterView.buyAgainBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            //再次购买
            [strongSelf purchaseOrderBuyAgainWithOrder:self.orderArray[section]];
        };
        
        return sectionFooterView;
        
    } else {
        
        UIView *footerView = [UIView new];
        return footerView;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJOrderModel *order =  self.orderArray[indexPath.section];

    switch (order.individualOrderType) {
        case OrderTypePurchase:
        {
            NSString *purchaseOrderCellIdentifier = @"purchaseOrderCellIdentifier";
            
            WJPurchaseOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:purchaseOrderCellIdentifier];
            if (!cell) {
                cell = [[WJPurchaseOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:purchaseOrderCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = WJColorWhite;
                cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
            }
            
            if (self.orderArray.count > 0) {
                
                WJOrderModel *order = self.orderArray[indexPath.section];
                [cell configDataWithProduct:order.productList[indexPath.row]];
            }
            
            return cell;
        }
            break;
            
        case OrderTypeRecharge:
        {
            NSString *rechargeOrderCellIdentifier = @"rechargeOrderCellIdentifier";
            
            WJChargeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:rechargeOrderCellIdentifier];
            if (!cell) {
                cell = [[WJChargeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rechargeOrderCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = WJColorWhite;
                cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
            }
            
            __weak typeof(self) weakSelf = self;
            
            cell.payRightNowBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                //付款
                [strongSelf rechargeOrderPayRightNowWithOrder:self.orderArray[indexPath.section]];
            };
            
            cell.cancelOrderBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                
                //取消订单
                [strongSelf rechargeOrderCancelOrderWithOrder:self.orderArray[indexPath.section]];
            };
            
            
            cell.deleteOrderBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                //删除
                [strongSelf rechargeOrderDeleteOrderWithOrder:self.orderArray[indexPath.section]];
            };
            
            cell.chargeAgainBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                //再次充值
                [strongSelf rechargeOrderRechagreAgainWithOrder:self.orderArray[indexPath.section]];
            };
            
            if (self.orderArray.count > 0) {
                
                WJOrderModel *order = self.orderArray[indexPath.section];
                [cell configDataWithOrder:order];
            }
            
            return cell;
        }
            break;
            
        case OrderTypeGiving:
        {
            NSString *givingOrderCellIdentifier = @"givingOrderCellIdentifier";
            
            WJGivingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:givingOrderCellIdentifier];
            if (!cell) {
                cell = [[WJGivingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:givingOrderCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = WJColorWhite;
                cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
            }
            
            __weak typeof(self) weakSelf = self;
            
            
            cell.cancelCheckBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                
                //取消审核
                [strongSelf givingOrderCancelCheckWithOrder:self.orderArray[indexPath.section]];
            };
            
            
            cell.deleteOrderBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                //删除
                [strongSelf givingOrderDeleteOrderWithOrder:self.orderArray[indexPath.section]];
            };
            
            if (self.orderArray.count > 0) {
                
                WJOrderModel *order = self.orderArray[indexPath.section];
                [cell configDataWithOrder:order];
            }
            
            return cell;
        }
            break;
            
        case OrderTypeTrading:
        {
            NSString *tradingOrderCellIdentifier = @"tradingOrderCellIdentifier";
            
            WJTradingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:tradingOrderCellIdentifier];
            if (!cell) {
                cell = [[WJTradingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tradingOrderCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = WJColorWhite;
                cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
            }
            
            __weak typeof(self) weakSelf = self;
            
            cell.payRightNowBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                //付款
                [strongSelf tradingOrderPayRightNowWithOrder:self.orderArray[indexPath.section]];
            };
            
            cell.cancelOrderBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                
                //取消订单
                [strongSelf tradingOrderCancelOrderWithOrder:self.orderArray[indexPath.section]];
            };
            
            
            cell.deleteOrderBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                //删除
                [strongSelf tradingOrderDeleteOrderWithOrder:self.orderArray[indexPath.section]];
            };
            
            cell.buyAgainBlock = ^ {
                __strong typeof(self) strongSelf = weakSelf;
                //再次购买
                [strongSelf tradingOrderBuyAgainWithOrder:self.orderArray[indexPath.section]];
            };
            
            if (self.orderArray.count > 0) {
                
                WJOrderModel *order = self.orderArray[indexPath.section];
                [cell configDataWithOrder:order];
            }
            
            return cell;

        }
            break;

        default:
        {
            NSString *defaultCellIdentifier = @"defaultCellIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = WJColorWhite;
                cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
            }
            
            return cell;
        }
            break;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJOrderModel *order = self.orderArray[indexPath.section];
    
    if (order.individualOrderType == OrderTypePurchase) {
        
//        WJPurchaseOrderDetailController *purchaseOrderDetailVC = [[WJPurchaseOrderDetailController alloc] init];
//        [self.navigationController pushViewController:purchaseOrderDetailVC animated:YES];
        
    } else {
        
        WJRechargeOrderDetailViewController *rechargeOrderDetailVC = [[WJRechargeOrderDetailViewController alloc] init];
        rechargeOrderDetailVC.orderModel = self.orderArray[indexPath.section];
        [self.navigationController pushViewController:rechargeOrderDetailVC animated:YES];
        
    }
}

#pragma mark - PurchaseOrderAction
-(void)purchaseOrderPayRightNowWithOrder:(WJOrderModel *)order
{
    NSLog(@"付款");
}

-(void)purchaseOrderCheckLogisticseWithOrder:(WJOrderModel *)order
{
    NSLog(@"查看物流");
    WJLogisticsDetailViewController *logisticsDetailVC = [[WJLogisticsDetailViewController alloc] init];
    logisticsDetailVC.orderId = order.orderNo;
    [self.navigationController pushViewController:logisticsDetailVC animated:YES];

}

-(void)purchaseOrderFinishOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"完成");
    
}

-(void)purchaseOrderDeleteOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"删除");
}


-(void)purchaseOrderRefundWithOrder:(WJOrderModel *)order
{
    NSLog(@"退款");
    
}

-(void)purchaseOrderRefundDetailWithOrder:(WJOrderModel *)order
{
    NSLog(@"退款详情");
    
}

-(void)purchaseOrderCancelOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"取消");
}

-(void)purchaseOrderBuyAgainWithOrder:(WJOrderModel *)order
{
    NSLog(@"再次购买");
}


#pragma mark - RechargeOrderAction
-(void)rechargeOrderPayRightNowWithOrder:(WJOrderModel *)order
{
    
}

-(void)rechargeOrderCancelOrderWithOrder:(WJOrderModel *)order
{
    
}

-(void)rechargeOrderDeleteOrderWithOrder:(WJOrderModel *)order
{
    
}

-(void)rechargeOrderRechagreAgainWithOrder:(WJOrderModel *)order
{
    
}

#pragma mark - GivingOrderAction
-(void)givingOrderCancelCheckWithOrder:(WJOrderModel *)order
{
    
}

-(void)givingOrderDeleteOrderWithOrder:(WJOrderModel *)order
{
    
}


#pragma maek - TradingOrderAction
-(void)tradingOrderPayRightNowWithOrder:(WJOrderModel *)order
{
    
}

-(void)tradingOrderCancelOrderWithOrder:(WJOrderModel *)order
{
    
}

-(void)tradingOrderDeleteOrderWithOrder:(WJOrderModel *)order
{
    
}

-(void)tradingOrderBuyAgainWithOrder:(WJOrderModel *)order
{
    
}

#pragma mark - setter/getter
-(WJRefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - kNavigationBarHeight) style:UITableViewStyleGrouped refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.contentInset = UIEdgeInsetsMake(-ALD(40), 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (NSMutableArray *)orderArray{
    if (!_orderArray) {
        //        _orderArray = [NSMutableArray array];
        
        WJProductModel *product1 = [[WJProductModel alloc] init];
        product1.name = @"茶水壶";
        product1.standardDes = @"43mmx56mm";
        product1.count = 1;
        
        WJProductModel *product2 = [[WJProductModel alloc] init];
        product2.name = @"电暖壶";
        product2.standardDes = @"30mmx40mm";
        product2.count = 1;
        
        WJOrderModel *order1 = [[WJOrderModel alloc] init];
        order1.orderStatus = OrderStatusUnfinished;
        order1.shopName = @"养生专访";
        order1.freight = @"34积分";
        order1.PayAmount = @"4323积分";
        order1.individualOrderType =  OrderTypePurchase;
        order1.productList = [NSMutableArray arrayWithObjects:product1,product2 ,nil];
        
        WJOrderModel *order2 = [[WJOrderModel alloc] init];
        order2.orderStatus = OrderStatusUnfinished;
        order2.shopName = @"可用积分充值";
        order2.orderType = @"充值";
        order2.PayAmount = @"5000";
        order2.chargeCredits = @"50000";
        order2.individualOrderType =  OrderTypeRecharge;
        
        WJOrderModel *order3 = [[WJOrderModel alloc] init];
        order3.orderStatus = OrderStatusWaitReceive;
        order3.shopName = @"耐克男子";
        order3.freight = @"100积分";
        order3.PayAmount = @"4323积分";
        order3.individualOrderType =  OrderTypePurchase;
        order3.productList = [NSMutableArray arrayWithObjects:product1 ,nil];

        
        WJOrderModel *order4 = [[WJOrderModel alloc] init];
        order4.orderStatus = OrderStatusSuccess;
        order4.shopName = @"可用积分充值";
        order4.orderType = @"充值";
        order4.PayAmount = @"1000";
        order4.chargeCredits = @"50000";
        order4.individualOrderType =  OrderTypeRecharge;

        
        WJOrderModel *order5 = [[WJOrderModel alloc] init];
        order5.orderStatus = OrderStatusClose;
        order5.shopName = @"可用积分充值";
        order5.orderType = @"充值";
        order5.PayAmount = @"1000";
        order5.chargeCredits = @"50000";
        order5.individualOrderType =  OrderTypeRecharge;

        
        WJOrderModel *order6 = [[WJOrderModel alloc] init];
        order6.orderStatus = OrderStatusWaitCheck;
        order6.shopName = @"可用积分赠送";
        order6.orderType = @"赠送";
        order6.PayAmount = @"5000";
        order6.chargeCredits = @"50000";
        order6.individualOrderType =  OrderTypeGiving;

        
        WJOrderModel *order7 = [[WJOrderModel alloc] init];
        order7.orderStatus = OrderStatusCancelCheck;
        order7.shopName = @"可用积分赠送";
        order7.orderType = @"赠送";
        order7.PayAmount = @"2000";
        order7.chargeCredits = @"50000";
        order7.individualOrderType =  OrderTypeGiving;

        
        
        WJOrderModel *order8 = [[WJOrderModel alloc] init];
        order8.orderStatus = OrderStatusSuccess;
        order8.shopName = @"隔代取筹积分转化";
        order8.orderType = @"隔代取筹";
        order8.PayAmount = @"3000";
        order8.chargeCredits = @"30000";
        order8.individualOrderType =  OrderTypeGiving;

        
        WJOrderModel *order9 = [[WJOrderModel alloc] init];
        order9.orderStatus = OrderStatusSuccess;
        order9.shopName = @"可用积分激活";
        order9.orderType = @"激活或者复投";
        order9.PayAmount = @"3000";
        order9.chargeCredits = @"30000";
        order9.individualOrderType =  OrderTypeGiving;

        
        WJOrderModel *order10 = [[WJOrderModel alloc] init];
        order10.orderStatus = OrderStatusUnfinished;
        order10.shopName = @"可用积分交易";
        order10.orderType = @"积分交易大厅";
        order10.PayAmount = @"5000";
        order10.chargeCredits = @"50000";
        order10.individualOrderType =  OrderTypeTrading;

        
        WJOrderModel *order11 = [[WJOrderModel alloc] init];
        order11.orderStatus = OrderStatusSuccess;
        order11.shopName = @"可用积分充值";
        order11.orderType = @"积分交易大厅";
        order11.PayAmount = @"2000";
        order11.chargeCredits = @"50000";
        order11.individualOrderType =  OrderTypeTrading;

        
        WJOrderModel *order12 = [[WJOrderModel alloc] init];
        order12.orderStatus = OrderStatusClose;
        order12.shopName = @"可用积分充值";
        order12.orderType = @"积分交易大厅";
        order12.PayAmount = @"1000";
        order12.chargeCredits = @"50000";
        order12.individualOrderType =  OrderTypeTrading;

        
        _orderArray = [NSMutableArray arrayWithObjects:order1,order2,order3, order4, order5,order6,order7,order8,order9,order10,order11 ,order12,nil];
    }
    return _orderArray;
}
@end
