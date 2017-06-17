//
//  WJPurchaseIntegralViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPurchaseIntegralViewController.h"
#import "WJCanUseIntegralCell.h"
#import "WJRefreshTableView.h"
#import "APIQueryIntergralListManager.h"
@interface WJPurchaseIntegralViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}
@property(nonatomic,strong)APIQueryIntergralListManager *queryIntergralListManager;
@property(nonatomic,strong)WJRefreshTableView       *tableView;
@property(nonatomic,strong)NSMutableArray           *listArray;
@end

@implementation WJPurchaseIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物积分";
    self.isHiddenTabBar = YES;
    
    [self SetUI];
    [self.view addSubview:self.tableView];
    
    [self requestData];
}

-(void)SetUI
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(170))];
    topView.backgroundColor = WJColorMainColor;
    
    UILabel *canUseIntegralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(20), ALD(100), ALD(20))];
    canUseIntegralL.text = @"购物积分";
    canUseIntegralL.textColor = WJColorWhite;
    canUseIntegralL.font = WJFont15;
    
    
    UILabel *integralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), canUseIntegralL.bottom + ALD(23), kScreenWidth - ALD(32) - ALD(120) , ALD(50))];
    integralL.textColor = WJColorWhite;
    integralL.textAlignment = NSTextAlignmentLeft;
    integralL.font = WJFont45;
    integralL.text = @"2350积分";
    
    
    [self.view addSubview:topView];
    [topView addSubview:canUseIntegralL];
    [topView addSubview:integralL];
}

-(void)requestData
{
    if (self.listArray.count > 0) {
        [self.listArray removeAllObjects];
    }
    self.queryIntergralListManager.shouldCleanData = YES;
    self.queryIntergralListManager.firstPageNo = 1;
    [self.queryIntergralListManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startHeadRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.queryIntergralListManager.shouldCleanData = YES;
        [self.queryIntergralListManager loadData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.queryIntergralListManager.shouldCleanData = NO;
        [self.queryIntergralListManager loadData];
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
        
        //        self.tableView.tableFooterView = noDataView;
    }
    
}



#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIQueryIntergralListManager class]]) {
        
//        self.orderListModel = [manager fetchDataWithReformer:[[WJOrderListReformer alloc] init]];
//        
//        if (self.orderArray.count == 0) {
//            
//            self.orderArray =  self.orderListModel.orderList;
//            
//        } else {
//            
//            if (self.orderManager.firstPageNo < self.orderListModel.totalPage) {
//                
//                [self.orderArray addObjectsFromArray: self.orderListModel.orderList];
//            }
//        }
        
        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
    }
}


- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIQueryIntergralListManager class]]) {
        
//        if (manager.errorType == APIManagerErrorTypeNoData) {
//            [self refreshFooterStatus:YES];
//            
//            if (isHeaderRefresh) {
//                if (self.orderArray.count > 0) {
//                    [self.orderArray removeAllObjects];
//                    
//                }
//                [self endGetData:YES];
//                return;
//            }
//            [self endGetData:NO];
//            
//        } else {
//            
//            [self refreshFooterStatus:self.orderManager.hadGotAllData];
//            [self endGetData:NO];
//            
//        }
        
    }
}



#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJCanUseIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJPurchaseIntegralCellIdentifier"];
    
    if (cell == nil) {
        cell = [[WJCanUseIntegralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJPurchaseIntegralCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, ALD(170), kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(170)) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(APIQueryIntergralListManager *)queryIntergralListManager
{
    if (!_queryIntergralListManager) {
        _queryIntergralListManager = [[APIQueryIntergralListManager alloc] init];
        _queryIntergralListManager.delegate = self;
    }
    _queryIntergralListManager.integralType = 5;
    return _queryIntergralListManager;
}


@end
