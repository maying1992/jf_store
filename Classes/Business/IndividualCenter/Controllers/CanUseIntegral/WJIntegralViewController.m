//
//  WJIntegralViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralViewController.h"
#import "WJCanUseIntegralViewController.h"
#import "WJPurchaseIntegralViewController.h"
#import "WJWaitUseIntegralViewController.h"
#import "WJShareIntegralViewController.h"
#import "WJMultifunctionIntegralViewController.h"
#import "WJIntegralActivateViewController.h"
#import "WJGivingListViewController.h"
#import "APIQueryAllIntegralInfoManager.h"
#import "WJAllTypeIntegralModel.h"
#import "WJSystemAlertView.h"
#import "WJBindindConsumerServicesCenterViewController.h"
@interface WJIntegralViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate,WJSystemAlertViewDelegate>
{
    UIButton *activateButton;
}
@property(nonatomic,strong)APIQueryAllIntegralInfoManager *queryAllIntegralInfoManager;
@property(nonatomic,strong)UITableView                    *tableView;
@property(nonatomic,strong)NSArray                        *listArray;
@property(nonatomic,strong)WJAllTypeIntegralModel         *allTypeIntegralModel;

@end

@implementation WJIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    [self setUI];
    
    [self.queryAllIntegralInfoManager loadData];
}

-(void)setUI
{
    UIButton *givingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    givingButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth/2, ALD(44));
    [givingButton setTitle:@"赠送" forState:UIControlStateNormal];
    [givingButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    givingButton.backgroundColor = WJColorWhite;
    [givingButton addTarget:self action:@selector(givingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:givingButton];
    
    
    activateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    activateButton.frame = CGRectMake(givingButton.right, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth/2, ALD(44));
    [activateButton setTitle:@"激活/复投" forState:UIControlStateNormal];
    [activateButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    activateButton.backgroundColor = WJColorMainColor;
    [activateButton addTarget:self action:@selector(activateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activateButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIQueryAllIntegralInfoManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];

        self.allTypeIntegralModel = [[WJAllTypeIntegralModel alloc] initWithDic:dic];
        
        
        if (self.allTypeIntegralModel.operationStatus == 1) {
            
            [activateButton setTitle:@"激活" forState:UIControlStateNormal];

            
        } else if (self.allTypeIntegralModel.operationStatus == 2) {
            
            [activateButton setTitle:@"激活" forState:UIControlStateNormal];

        } else {
            
            [activateButton setTitle:@"复投" forState:UIControlStateNormal];

        }
        
        [self.tableView reloadData];

    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{

}


#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJIntegralCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJIntegralCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(100), ALD(44))];
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont14;
        nameL.tag = 1001;
        [cell.contentView addSubview:nameL];
        
        UILabel *integralL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(30) - ALD(200), 0, ALD(200), ALD(44))];
        integralL.textColor = WJColorDardGray3;
        integralL.font = WJFont14;
        integralL.tag = 1002;
        integralL.textAlignment = NSTextAlignmentRight;

        [cell.contentView addSubview:integralL];

    }
    
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:1001];
    nameL.text = [self.listArray[indexPath.row] objectForKey:@"text"];
    
    UILabel *integralL = (UILabel *)[cell.contentView viewWithTag:1002];

    
    switch (indexPath.row) {
        case 0:
        {
            integralL.text = [NSString stringWithFormat:@"%@积分",self.allTypeIntegralModel.canUseIntegral];
        }
            break;
        case 1:
        {
            integralL.text = [NSString stringWithFormat:@"%@积分",self.allTypeIntegralModel.shopIntegral];

        }
            break;
            
        case 2:
        {
            integralL.text = [NSString stringWithFormat:@"%@积分",self.allTypeIntegralModel.waitUseIntegral];

        }
            break;
            
        case 3:
        {
            integralL.text = [NSString stringWithFormat:@"%@积分",self.allTypeIntegralModel.multifunctionalIntegral];

        }
            break;
            
        case 4:
        {
            integralL.text = [NSString stringWithFormat:@"%@积分",self.allTypeIntegralModel.shareIntegral];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            WJCanUseIntegralViewController *canUseIntegralVC = [[WJCanUseIntegralViewController alloc] init];
            [self.navigationController pushViewController:canUseIntegralVC animated:YES];
        }
            break;
        case 1:
        {
            WJPurchaseIntegralViewController *purchaseIntegralVC = [[WJPurchaseIntegralViewController alloc] init];
            [self.navigationController pushViewController:purchaseIntegralVC animated:YES];
            
        }
            break;
            
        case 2:
        {
            WJWaitUseIntegralViewController *waitUseIntegralVC = [[WJWaitUseIntegralViewController alloc] init];
            [self.navigationController pushViewController:waitUseIntegralVC animated:YES];

        }
            break;
            
        case 3:
        {
            WJMultifunctionIntegralViewController *multifunctionIntegralVC = [[WJMultifunctionIntegralViewController alloc] init];
            [self.navigationController pushViewController:multifunctionIntegralVC animated:YES];

        }
            break;
            
        case 4:
        {
            WJShareIntegralViewController *shareIntegralVC = [[WJShareIntegralViewController alloc] init];
            [self.navigationController pushViewController:shareIntegralVC animated:YES];

        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        WJBindindConsumerServicesCenterViewController *bindindConsumerServicesCenterVC = [[WJBindindConsumerServicesCenterViewController alloc] init];
        [self.navigationController pushViewController:bindindConsumerServicesCenterVC animated:YES];
    }
}


#pragma mark - Action
-(void)givingButtonAction
{
    WJGivingListViewController *givingListVC = [[WJGivingListViewController alloc] init];
    [self.navigationController pushViewController:givingListVC animated:YES];
}


-(void)activateButtonAction
{
    
    NSString *title = nil;
    if (self.allTypeIntegralModel.operationStatus == 1) {
        
        WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"绑定消费服务" message:@"您还未绑定消费服务中心，去绑定？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
        [alertView showIn];
        
    } else if (self.allTypeIntegralModel.operationStatus == 2) {
        
        title = @"激活";

        WJIntegralActivateViewController *integralActivateVC = [[WJIntegralActivateViewController alloc] init];
        integralActivateVC.title = title;
        integralActivateVC.doubleTotalIntegral = self.allTypeIntegralModel.doubleTotalIntegral;
        [self.navigationController pushViewController:integralActivateVC animated:YES];
        
    } else {
        
        title = @"复投";
        
        WJIntegralActivateViewController *integralActivateVC = [[WJIntegralActivateViewController alloc] init];
        integralActivateVC.title = title;
        integralActivateVC.doubleTotalIntegral = self.allTypeIntegralModel.doubleTotalIntegral;
        [self.navigationController pushViewController:integralActivateVC animated:YES];
    }

}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain];
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
             @{@"text":@"可用积分"},
             @{@"text":@"购物积分"},
             @{@"text":@"待用积分"},
             @{@"text":@"多功能积分"},
             @{@"text":@"分享积分"}
             ];
}

-(APIQueryAllIntegralInfoManager *)queryAllIntegralInfoManager
{
    if (!_queryAllIntegralInfoManager) {
        _queryAllIntegralInfoManager = [[APIQueryAllIntegralInfoManager alloc] init];
        _queryAllIntegralInfoManager.delegate = self;
    }
    return _queryAllIntegralInfoManager;
}

@end
