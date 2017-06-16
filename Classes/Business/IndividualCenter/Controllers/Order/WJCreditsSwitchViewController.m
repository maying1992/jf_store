//
//  WJCreditsSwitchViewController.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCreditsSwitchViewController.h"
#import "WJCreditsSwitchCell.h"
@interface WJCreditsSwitchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray     *orderArray;

@end

@implementation WJCreditsSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分互转订单";
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
    return ALD(90);
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
    
    WJCreditsSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
    if (!cell) {
        cell = [[WJCreditsSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    if (self.orderArray.count > 0) {
        
        WJOrderModel *order = self.orderArray[indexPath.section];
        [cell configDataWithOrder:order];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
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
        order1.shopName = @"用户A";
        order1.orderType = @"积分互转";
        order1.PayAmount = @"5000";
        order1.chargeCredits = @"50000";
        
        
        WJOrderModel *order2 = [[WJOrderModel alloc] init];
        order2.orderStatus = OrderStatusSuccess;
        order2.shopName = @"用户B";
        order2.orderType = @"积分互转";
        order2.PayAmount = @"5000";
        order2.chargeCredits = @"50000";
        
        _orderArray = [NSMutableArray arrayWithObjects:order1,order2, nil];
        
    }
    return _orderArray;
}

@end
