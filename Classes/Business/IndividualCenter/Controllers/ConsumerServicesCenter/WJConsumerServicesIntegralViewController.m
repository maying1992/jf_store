//
//  WJConsumerServicesIntegralViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerServicesIntegralViewController.h"
#import "WJConsumerServiceTopView.h"
#import "WJConsumerServiceIntegralCell.h"
#import "WJConsumerActivateViewController.h"
#import "WJRechargeRedIntegralViewController.h"
#import "APIQueryServiceCenterManager.h"
#import "WJRefreshTableView.h"
#import "WJConsumeServiceQueryReformer.h"
#import "WJServiceCenterQueryModel.h"
#import "WJConsumerServicesPayViewController.h"
@interface WJConsumerServicesIntegralViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}

@property(nonatomic,strong)WJServiceCenterQueryModel    *serviceCenterQueryModel;
@property(nonatomic,strong)WJConsumerServiceTopView     *topView;
@property(nonatomic,strong)WJRefreshTableView           *tableView;
@property(nonatomic,strong)NSMutableArray               *listArray;
@property(nonatomic,strong)APIQueryServiceCenterManager *queryServiceCenterManager;

@end

@implementation WJConsumerServicesIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费服务中心";
    self.isHiddenTabBar = YES;
    [self navigationSetup];
    [self UISetup];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topView;
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationSetup
{
    UIButton *activateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    activateButton.frame = CGRectMake(0, 0, ALD(40), ALD(30));
    activateButton.titleLabel.font = WJFont14;
    [activateButton setTitle:@"激活" forState:UIControlStateNormal];
    [activateButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [activateButton addTarget:self action:@selector(activateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activateButton];
    
}

-(void)UISetup
{
    UIButton *renewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    renewButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [renewButton setTitle:@"消费服务中心续费" forState:UIControlStateNormal];
    renewButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [renewButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    renewButton.backgroundColor = WJColorMainColor;
    renewButton.titleLabel.font = WJFont14;
    
    [renewButton addTarget:self action:@selector(renewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:renewButton];
}

#pragma mark - Request

- (void)requestData{
    
    if (self.listArray.count > 0) {
        [self.listArray removeAllObjects];
    }
    self.queryServiceCenterManager.shouldCleanData = YES;
    self.queryServiceCenterManager.firstPageNo = 1;
    [self.queryServiceCenterManager loadData];
}

#pragma mark - WJRefreshTableView Delegate

- (void)startHeadRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.queryServiceCenterManager.shouldCleanData = YES;
        [self requestData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.queryServiceCenterManager.shouldCleanData = NO;
        [self.queryServiceCenterManager loadData];
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
    
    if (self.listArray.count > 0) {
        self.tableView.tableFooterView = [UIView new];
        
    } else {
        
        //        self.tableView.tableFooterView = nil;
    }
    
}

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIQueryServiceCenterManager class]]) {
        
        self.serviceCenterQueryModel = [manager fetchDataWithReformer:[[WJConsumeServiceQueryReformer alloc] init]];
        
        if (self.listArray.count == 0) {
            
            self.listArray =  self.serviceCenterQueryModel.integralList;
            
        } else {
            
            if (self.queryServiceCenterManager.firstPageNo < self.serviceCenterQueryModel.totalPage) {
                
                [self.listArray addObjectsFromArray: self.serviceCenterQueryModel.integralList];
            }
        }
        
        [self.topView configDataWithModel:self.serviceCenterQueryModel];

        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIQueryServiceCenterManager class]]) {
        
        if (manager.errorType == APIManagerErrorTypeNoData) {
            [self refreshFooterStatus:YES];
            
            if (isHeaderRefresh) {
                if (self.listArray.count > 0) {
                    [self.listArray removeAllObjects];
                    
                }
                [self endGetData:YES];
                return;
            }
            [self endGetData:NO];
            
        } else {
            
            [self refreshFooterStatus:self.queryServiceCenterManager.hadGotAllData];
            [self endGetData:NO];
            
        }
        
    }
}



#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.listArray == nil || self.listArray.count == 0) {
        return 0;
    } else {
        return self.listArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(44);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = WJColorWhite;
    
    UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, ALD(44))];
    timeL.textColor = WJColorDardGray3;
    timeL.textAlignment = NSTextAlignmentCenter;
    timeL.text = @"时间";
    timeL.font = WJFont15;
    
    
    UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake(timeL.right, 0, kScreenWidth/3, ALD(44))];
    detailL.text = @"详情";
    detailL.textColor = WJColorDardGray3;
    detailL.font = WJFont15;
    detailL.textAlignment = NSTextAlignmentCenter;

    
    
    UILabel *integralChangeL = [[UILabel alloc] initWithFrame:CGRectMake(detailL.right, 0, kScreenWidth/3, ALD(44))];
    integralChangeL.text = @"积分变动";
    integralChangeL.textColor = WJColorDardGray3;
    integralChangeL.font = WJFont15;
    integralChangeL.textAlignment = NSTextAlignmentCenter;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ALD(12), ALD(44) - 0.5, kScreenWidth - ALD(24), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;

    
    [headerView addSubview:timeL];
    [headerView addSubview:detailL];
    [headerView addSubview:integralChangeL];
    [headerView addSubview:line];
    
    
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJConsumerServiceIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPaymentIdentifier"];
    
    if (cell == nil) {
        cell = [[WJConsumerServiceIntegralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectPaymentIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    
    [cell configDataWithModel:self.listArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma mark - Action
-(void)activateButtonAction
{
    WJConsumerActivateViewController *consumerActivateVC = [[WJConsumerActivateViewController alloc] init];
    [self.navigationController pushViewController:consumerActivateVC animated:YES];
}


-(void)renewButtonAction
{
    WJConsumerServicesPayViewController *consumerServicesPayVC = [[WJConsumerServicesPayViewController alloc] init];
    [self.navigationController pushViewController:consumerServicesPayVC animated:YES];
}

-(WJConsumerServiceTopView *)topView
{
    if (!_topView) {
        _topView = [[WJConsumerServiceTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(214) - kNavigationBarHeight)];
        _topView.backgroundColor = WJColorMainColor;

        __weak typeof(self) weakSelf = self;
        
        _topView.rechargeRedIntegralBlock = ^ {
            
            __strong typeof(self) strongSelf = weakSelf;
            
            WJRechargeRedIntegralViewController *rechargeRedIntegralVC = [[WJRechargeRedIntegralViewController alloc] init];
            [strongSelf.navigationController pushViewController:rechargeRedIntegralVC animated:YES];
        };
        
    }
    return _topView;
}

#pragma mark - 属性方法
- (WJRefreshTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(APIQueryServiceCenterManager *)queryServiceCenterManager
{
    if (!_queryServiceCenterManager) {
        _queryServiceCenterManager = [[APIQueryServiceCenterManager alloc] init];
        _queryServiceCenterManager.delegate = self;
    }
    return _queryServiceCenterManager;
}
@end
