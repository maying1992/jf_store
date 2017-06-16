//
//  WJGivingOrderViewController.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingOrderViewController.h"
#import "WJGivingOrderCell.h"
#import "WJRechargeOrderDetailViewController.h"
@interface WJGivingOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray     *orderArray;

@end

@implementation WJGivingOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赠送订单";
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
    return ALD(135);
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
    
    WJGivingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
    if (!cell) {
        cell = [[WJGivingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    __weak typeof(self) weakSelf = self;
    
    
    cell.cancelCheckBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        
        //取消审核
        [strongSelf cancelCheckWithOrder:self.orderArray[indexPath.section]];
    };
    
    
    cell.deleteOrderBlock = ^ {
        __strong typeof(self) strongSelf = weakSelf;
        //删除
        [strongSelf deleteOrderWithOrder:self.orderArray[indexPath.section]];
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


-(void)deleteOrderWithOrder:(WJOrderModel *)order
{
    NSLog(@"删除");
}

-(void)cancelCheckWithOrder:(WJOrderModel *)order
{
    NSLog(@"取消");
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
        order1.orderStatus = OrderStatusCancelCheck;
        order1.individualOrderType = OrderTypeGiving;
        order1.shopName = @"可用积分赠送";
        order1.orderType = @"赠送";
        order1.PayAmount = @"5000";
        order1.chargeCredits = @"50000";
        
        
        WJOrderModel *order2 = [[WJOrderModel alloc] init];
        order2.orderStatus = OrderStatusSuccess;
        order2.individualOrderType = OrderTypeGiving;
        order2.shopName = @"可用积分赠送";
        order2.orderType = @"赠送";
        order2.PayAmount = @"5000";
        order2.chargeCredits = @"50000";
        
        WJOrderModel *order3 = [[WJOrderModel alloc] init];
        order3.orderStatus = OrderStatusWaitCheck;
        order3.individualOrderType = OrderTypeGiving;
        order3.shopName = @"可用积分充值";
        order3.orderType = @"隔代取筹";
        order3.PayAmount = @"5000";
        order3.chargeCredits = @"50000";
    
        
        _orderArray = [NSMutableArray arrayWithObjects:order1,order2,order3, nil];
        
    }
    return _orderArray;
}




@end
