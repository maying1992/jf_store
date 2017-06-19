//
//  WJGivingListViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingListViewController.h"
#import "WJGivingListTCell.h"
#import "WJIntegralGivingViewController.h"
#import "APIIntegralGivingManager.h"
#import "WJGivingIntegralListReformer.h"
#import "WJGivingIntegralListModel.h"
@interface WJGivingListViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}
@property(nonatomic,strong)WJRefreshTableView        *tableView;
@property(nonatomic,strong)NSMutableArray            *listArray;
@property(nonatomic,strong)APIIntegralGivingManager  *integralGivingManager;
@property(nonatomic,strong)WJGivingIntegralListModel *givingIntegralListModel;
@end

@implementation WJGivingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赠送";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.tableView];
    
    [self requestData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request

- (void)requestData{
    
    if (self.listArray.count > 0) {
        [self.listArray removeAllObjects];
    }
    self.integralGivingManager.shouldCleanData = YES;
    self.integralGivingManager.firstPageNo = 1;
    [self.integralGivingManager loadData];
}

#pragma mark - WJRefreshTableView Delegate

- (void)startHeadRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.integralGivingManager.shouldCleanData = YES;
        [self requestData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.integralGivingManager.shouldCleanData = NO;
        [self.integralGivingManager loadData];
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
    if ([manager isKindOfClass:[APIIntegralGivingManager class]]) {
        
        self.givingIntegralListModel = [manager fetchDataWithReformer:[[WJGivingIntegralListReformer alloc] init]];
        
        if (self.listArray.count == 0) {
            
            self.listArray =  self.givingIntegralListModel.list;
            
        } else {
            
            if (self.integralGivingManager.firstPageNo < self.givingIntegralListModel.totalPage) {
                
                [self.listArray addObjectsFromArray: self.givingIntegralListModel.list];
            }
        }
        
        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIIntegralGivingManager class]]) {
        
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
            
            [self refreshFooterStatus:self.integralGivingManager.hadGotAllData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJGivingListTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJGivingListTCellIdentifier"];
    
    if (cell == nil) {
        cell = [[WJGivingListTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJGivingListTCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    [cell configDataWithModel:self.listArray[indexPath.row]];
    
    __weak typeof(self) weakSelf = self;

    cell.tapGivingBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;

        WJIntegralGivingViewController *integralGivingVC = [[WJIntegralGivingViewController alloc] init];
        [strongSelf.navigationController pushViewController:integralGivingVC animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


-(APIIntegralGivingManager *)integralGivingManager
{
    if (!_integralGivingManager) {
        _integralGivingManager = [[APIIntegralGivingManager alloc] init];
        _integralGivingManager.delegate = self;
    }
    return _integralGivingManager;
}


@end
