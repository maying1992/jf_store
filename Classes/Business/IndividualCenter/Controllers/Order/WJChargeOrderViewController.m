//
//  WJChargeOrderViewController.m
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJChargeOrderViewController.h"
#import "WJChargeOrderCell.h"
#import "WJRechargeOrderDetailViewController.h"
@interface WJChargeOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray     *orderArray;
@end

@implementation WJChargeOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值订单";
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
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(185);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ALD(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *orderCellIdentifier = @"orderCellIdentifier";
    
    WJChargeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
    if (!cell) {
        cell = [[WJChargeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    __weak typeof(self) weakSelf = self;
    
    cell.payRightNowBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;
        //付款
        [strongSelf payRightNowWithOrder:self.orderArray[indexPath.section]];
    };
    
    cell.cancelOrderBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        
        //取消订单
        [strongSelf cancelOrderWithOrder:self.orderArray[indexPath.section]];
    };
    
    
    cell.deleteOrderBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //删除
        [strongSelf deleteOrderWithOrder:self.orderArray[indexPath.section]];
    };
    
    cell.chargeAgainBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //再次购买
        [strongSelf chargeAgainWithOrder:self.orderArray[indexPath.section]];
    };
    
    if (self.orderArray.count > 0) {
        
        WJOrderModel *order = self.orderArray[indexPath.section];
        [cell configDataWithOrder:order];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJRechargeOrderDetailViewController *rechargeOrderDetailVC = [[WJRechargeOrderDetailViewController alloc] init];
    rechargeOrderDetailVC.orderModel = self.orderArray[indexPath.section];
    [self.navigationController pushViewController:rechargeOrderDetailVC animated:YES];
    
}

-(void)payRightNowWithOrder:(WJOrderModel *)order
{
    NSLog(@"付款");
}

-(void)deleteOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"删除");
}

-(void)cancelOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"取消");
}

-(void)chargeAgainWithOrder:(WJOrderModel *)order
{
    NSLog(@"再次充值");
    
}


#pragma mark - setter/getter
-(WJRefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -  - kNavigationBarHeight) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
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
        
        WJOrderModel *order1 = [[WJOrderModel alloc] init];
        order1.orderStatus = OrderStatusUnfinished;
        order1.individualOrderType = OrderTypeRecharge;
        order1.shopName = @"可用积分充值";
        order1.orderType = @"充值";
        order1.PayAmount = @"5000";
        order1.chargeCredits = @"50000";
        
        
        WJOrderModel *order2 = [[WJOrderModel alloc] init];
        order2.orderStatus = OrderStatusSuccess;
        order2.individualOrderType = OrderTypeRecharge;
        order2.shopName = @"可用积分充值";
        order2.orderType = @"充值";
        order2.PayAmount = @"5000";
        order2.chargeCredits = @"50000";
        
        WJOrderModel *order3 = [[WJOrderModel alloc] init];
        order3.orderStatus = OrderStatusClose;
        order3.individualOrderType = OrderTypeRecharge;
        order3.shopName = @"可用积分充值";
        order3.orderType = @"充值";
        order3.PayAmount = @"5000";
        order3.chargeCredits = @"50000";
        
        _orderArray = [NSMutableArray arrayWithObjects:order1,order2,order3, nil];

    }
    return _orderArray;
}


@end
