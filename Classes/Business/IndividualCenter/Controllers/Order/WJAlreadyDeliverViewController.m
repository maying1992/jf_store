//
//  WJAlreadyDeliverViewController.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAlreadyDeliverViewController.h"
#import "WJOrderCell.h"
#import "WJOrderCustomFooterView.h"
#import "WJOrderCell.h"
@interface WJAlreadyDeliverViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray     *orderArray;

@end

@implementation WJAlreadyDeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已发货";
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
    return ALD(124);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = WJColorWhite;
    
    UILabel *orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), ALD(200), ALD(20))];
    orderNoL.textColor = WJColorDarkGray;
    orderNoL.font = WJFont12;
    orderNoL.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:orderNoL];
    
    UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(10) - ALD(100), ALD(10), ALD(100), ALD(30))];
    statusL.textColor = WJColorDardGray3;
    statusL.font = WJFont12;
    statusL.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:statusL];
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), ALD(40) - 0.5, kScreenWidth - ALD(24), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;
    [headerView addSubview:line];
    
    WJOrderModel *order =  self.orderArray[section];
    
    orderNoL.text =  [NSString stringWithFormat:@"订单编号：%@",order.orderNo];
    
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
            
        case OrderStatusAlreadyRefund:
        {
            statusL.text = @"退款成功";
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
    
    WJOrderCustomFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    
    if(!sectionFooterView){
        
        sectionFooterView = [[WJOrderCustomFooterView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    
    WJOrderModel *order =  self.orderArray[section];
    [sectionFooterView configDataWithOrder:order];
    
    return sectionFooterView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *orderCellIdentifier = @"orderCellIdentifier";
    
    WJOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
    if (!cell) {
        cell = [[WJOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
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
    
    
}

#pragma mark - setter/getter
-(WJRefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kOrderTabSegmentHeight) style:UITableViewStyleGrouped refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
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
        order1.orderNo = @"7348723249872547";
        order1.orderStatus = OrderStatusWaitReceive;
        order1.freight = @"34积分";
        order1.PayAmount = @"4323积分";
        order1.address = @"圣帕特里克节创立于5世纪，是念护神的节特是多少来看发电量时看风景打赏块但是大家阿老KFJDSAFSDFFDSFd电风扇开发";
        
        
        WJOrderModel *order2 = [[WJOrderModel alloc] init];
        order2.orderNo = @"2348723249872547";
        order2.orderStatus = OrderStatusWaitReceive;
        order2.freight = @"34积分";
        order2.PayAmount = @"4323积分";
        order2.address = @"圣帕特里克节创立于5世纪，是念护神的节特是多少来看发电量时看风景打赏块但是大家阿老KFJDSAFSDFFDSFd电风扇开发";
        
        
        WJProductModel *product3 = [[WJProductModel alloc] init];
        product3.name = @"保温杯";
        product3.standardDes = @"30mmx40mm";
        product3.count = 1;
        
        order1.productList = [NSMutableArray arrayWithObjects:product1,product2 ,nil];
        order2.productList = [NSMutableArray arrayWithObjects:product3 ,product1,nil];
        
        _orderArray = [NSMutableArray arrayWithObjects:order1, order2,nil];
    }
    return _orderArray;
}

@end
