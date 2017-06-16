//
//  WJIndividualWaitingReceiveViewController.m
//  jf_store
//
//  Created by reborn on 17/5/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualWaitingReceiveViewController.h"
#import "WJProductModel.h"
#import "WJPurchaseFooterView.h"
#import "WJIndividualOrderDetailViewController.h"
#import "WJLogisticsDetailViewController.h"
#import "WJApplyRefundViewController.h"
#import "WJPurchaseOrderCell.h"
#import "APIIndividualOrderManager.h"
#import "WJOrderListReformer.h"
#import "WJIndividualOrderListModel.h"
@interface WJIndividualWaitingReceiveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}
@property(nonatomic,strong)APIIndividualOrderManager    *orderManager;
@property(nonatomic,strong)NSMutableArray               *orderArray;
@property(nonatomic,strong)WJIndividualOrderListModel   *orderListModel;
@end

@implementation WJIndividualWaitingReceiveViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待收货";
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
    _orderManager.orderStatus = OrderStatusWaitReceive;
    return _orderManager;
}

@end
