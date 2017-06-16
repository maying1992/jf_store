//
//  WJIndividualAllOrderViewController.m
//  jf_store
//
//  Created by reborn on 17/5/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualAllOrderViewController.h"
#import "WJPurchaseOrderCell.h"

#import "WJProductModel.h"
#import "WJPurchaseFooterView.h"
#import "WJIndividualOrderDetailViewController.h"
#import "WJLogisticsDetailViewController.h"
#import "WJApplyRefundViewController.h"
#import "APIIndividualOrderManager.h"
#import "WJOrderListReformer.h"
#import "WJIndividualOrderListModel.h"
#import "WJSystemAlertView.h"
#import "WJPassView.h"
#import "WJOnLinePayViewController.h"
#import "WJIntegralTradePasswordViewController.h"
@interface WJIndividualAllOrderViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate,WJSystemAlertViewDelegate,WJPassViewDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}
@property(nonatomic,strong)APIIndividualOrderManager    *orderManager;
@property(nonatomic,strong)NSMutableArray               *orderArray;
@property(nonatomic,strong)WJIndividualOrderListModel   *orderListModel;
@property(nonatomic,assign)NSInteger                    payType;
@property(nonatomic,strong)WJOrderModel                 *orderModel;

@end

@implementation WJIndividualAllOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部订单";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.tableView];
    [self requestData];
}

-(void)requestData
{
    if (self.orderArray.count > 0) {
        [self.orderArray removeAllObjects];
    }
    self.orderManager.shouldCleanData = YES;
    self.orderManager.firstPageNo = 1;
    [self.orderManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startHeadRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.orderManager.shouldCleanData = YES;
        [self.orderManager loadData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.orderManager.shouldCleanData = NO;
        [self.orderManager loadData];
    }
}

- (void)endGetData:(BOOL)needReloadData{
    
    if (isHeaderRefresh) {
        isHeaderRefresh = NO;
        [self.tableView endHeadRefresh];
    }
    
    if (isFooterRefresh){
        isFooterRefresh = NO;
        [self.tableView endFootFefresh];
    }
    
    if (needReloadData) {
        [self.tableView reloadData];
    }
}

- (void)refreshFooterStatus:(BOOL)status{
    
    if (status) {
        [self.tableView hiddenFooter];
    } else {
        [self.tableView showFooter];
    }
    
    if (self.orderArray.count > 0) {
        self.tableView.tableFooterView = [UIView new];
        
    } else {
        
        //        self.tableView.tableFooterView = noDataView;
    }
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIIndividualOrderManager class]]) {
        self.orderListModel = [manager fetchDataWithReformer:[[WJOrderListReformer alloc] init]];
        
        if (self.orderArray.count == 0) {
            
            self.orderArray =  self.orderListModel.orderList;
            
        } else {
            
            if (self.orderManager.firstPageNo < self.orderListModel.totalPage) {
                
                [self.orderArray addObjectsFromArray: self.orderListModel.orderList];
            }
        }
        
        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
    }
}


- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIIndividualOrderManager class]]) {
        
        if (manager.errorType == APIManagerErrorTypeNoData) {
            [self refreshFooterStatus:YES];
            
            if (isHeaderRefresh) {
                if (self.orderArray.count > 0) {
                    [self.orderArray removeAllObjects];
                    
                }
                [self endGetData:YES];
                return;
            }
            [self endGetData:NO];
            
        } else {
            
            [self refreshFooterStatus:self.orderManager.hadGotAllData];
            [self endGetData:NO];
            
        }
        
    }
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
    return order.productList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(130);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(40);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ALD(130);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
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
    
    WJOrderModel *order =  self.orderArray[section];
    
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
            
        case OrderStatusApplyRefund:
        {
            statusL.text = @"退款申请中";
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
            
        case OrderStatusRefuseRefund:
        {
            statusL.text = @"拒绝退款";
        }
            break;

        default:
            break;
    }
    
    
    return headerView;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
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
        [strongSelf payRightNowWithOrder:self.orderArray[section]];
    };
    
    sectionFooterView.cancelOrderBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        
        //取消订单
        [strongSelf cancelOrderWithOrder:self.orderArray[section]];
    };
    
    sectionFooterView.checkLogisticseBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        
        //查看物流
        [strongSelf checkLogisticseWithOrder:self.orderArray[section]];
        
    };
    
    sectionFooterView.finishBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        
        //完成
        [strongSelf finishOrderWithOrder:self.orderArray[section]];
        
    };
    
    sectionFooterView.buyAgainBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //再次购买
        [strongSelf buyAgainWithOrder:self.orderArray[section]];
    };
    
    sectionFooterView.refundBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //退款
        [strongSelf refundWithOrder:self.orderArray[section]];
        
    };
    
    sectionFooterView.refundDetailBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //退款详情
        [strongSelf refundDetailWithOrder:self.orderArray[section]];
    };
    
    sectionFooterView.cancelRefundBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //取消退款
        [strongSelf cancelRefundWithOrder:self.orderArray[section]];
    };
    
    
    return sectionFooterView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *orderCellIdentifier = @"orderCellIdentifier";
    
    WJPurchaseOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
    if (!cell) {
        cell = [[WJPurchaseOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJIndividualOrderDetailViewController *orderDetailVC = [[WJIndividualOrderDetailViewController alloc] init];
    orderDetailVC.orderModel = self.orderArray[indexPath.section];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

#pragma mark - WJPassViewDelegate
- (void)successWithVerifyPsdAlert:(WJPassView *)alertView
{
    switch (self.payType) {
            
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

#pragma mark - FooterView Method
-(void)payRightNowWithOrder:(WJOrderModel *)order
{
    NSLog(@"付款");
    
    switch (order.payType) {
        case 1:
        {
            //微信支付
            WJOnLinePayViewController *onLinePayVC = [[WJOnLinePayViewController alloc] init];
            onLinePayVC.orderModel = order;
            [self.navigationController pushViewController:onLinePayVC animated:YES];
            
        }
            break;
            
        case 2:
        {
            //支付宝支付
            WJOnLinePayViewController *onLinePayVC = [[WJOnLinePayViewController alloc] init];
            onLinePayVC.orderModel = order;
            [self.navigationController pushViewController:onLinePayVC animated:YES];
            
        }
            break;
            
        case 3:
        {
            //积分支付
            WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
            passView.delegate = self;
            [passView showIn];
            self.payType = order.payType;
            
            self.orderModel = order;
            
        }
            break;
            
        case 4:
        {
            //积分+微信
            WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
            passView.delegate = self;
            [passView showIn];
            
            self.payType = order.payType;
            self.orderModel = order;
            
            
        }
            break;
            
        case 5:
        {
            //积分+支付宝
            WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
            passView.delegate = self;
            [passView showIn];
            self.payType = order.payType;
            
            self.orderModel = order;

        }
            break;
            
        default:
            break;
    }
    
}

-(void)cancelOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"取消");
}

-(void)checkLogisticseWithOrder:(WJOrderModel *)order
{
    NSLog(@"查看物流");
    WJLogisticsDetailViewController *logisticsDetailVC = [[WJLogisticsDetailViewController alloc] init];
    logisticsDetailVC.orderId = order.orderNo;
    [self.navigationController pushViewController:logisticsDetailVC animated:YES];
}

-(void)finishOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"完成");
}

-(void)buyAgainWithOrder:(WJOrderModel *)order
{
    NSLog(@"再次购买");

}

-(void)refundWithOrder:(WJOrderModel *)order
{
    NSLog(@"退款");
    WJApplyRefundViewController *applyRefundVC = [[WJApplyRefundViewController alloc] init];
    [self.navigationController pushViewController:applyRefundVC animated:YES];
}

-(void)refundDetailWithOrder:(WJOrderModel *)order
{
    NSLog(@"退款详情");
    WJIndividualOrderDetailViewController *orderDetailVC = [[WJIndividualOrderDetailViewController alloc] init];
    orderDetailVC.orderModel = order;
    [self.navigationController pushViewController:orderDetailVC animated:YES];

}

-(void)cancelRefundWithOrder:(WJOrderModel *)order
{
    NSLog(@"取消退款");

}

#pragma mark - setter/getter
-(WJRefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - kNavBarAndStatBarHeight) style:UITableViewStyleGrouped refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.contentInset = UIEdgeInsetsMake(-ALD(40), 0, 0, 0);
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)orderArray{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}

-(APIIndividualOrderManager *)orderManager
{
    if (!_orderManager) {
        _orderManager = [[APIIndividualOrderManager alloc] init];
        _orderManager.delegate =  self;
    }
    _orderManager.orderStatus = OrderStatusAll;
    return _orderManager;
}


@end
