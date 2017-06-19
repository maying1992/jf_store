//
//  WJConsumerActivateViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerActivateViewController.h"
#import "WJConsumerActivateCell.h"
#import "WJMemberModel.h"
#import "WJSystemAlertView.h"
#import "APIServiceCenterActivateManager.h"
#import "APIServiceCenterActivationListManager.h"
#import "WJRefreshTableView.h"
#import "WJServiceCenterActivateReformer.h"
#import "WJServiceCenterActivateListModel.h"
#import "WJServiceCenterActivateModel.h"
@interface WJConsumerActivateViewController ()<UITableViewDelegate,UITableViewDataSource,WJSystemAlertViewDelegate,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}
@property(nonatomic,strong)APIServiceCenterActivateManager       *serviceCenterActivateManager;
@property(nonatomic,strong)APIServiceCenterActivationListManager *activationListManager;
@property(nonatomic,strong)WJRefreshTableView                    *tableView;
@property(nonatomic,strong)NSMutableArray                        *listArray;
@property(nonatomic,strong)NSMutableArray                        *integralIdlist;
@property(nonatomic,strong)NSString                              *integralIdStr;

@property(nonatomic,strong)WJServiceCenterActivateListModel      *activateListModel;

@end

@implementation WJConsumerActivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激活";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.tableView];
    
    [self requestData];
}

-(void)UISetup
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44))];
    bottomView.backgroundColor = WJColorWhite;
    [self.view addSubview:bottomView];
    
    UILabel *integralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, kScreenWidth - ALD(150), ALD(44))];
    integralL.textColor = WJColorBlack;
    integralL.font = WJFont14;
    integralL.text = [NSString stringWithFormat:@"红积分：%@  可用积分：%@",self.activateListModel.redIntegral,self.activateListModel.canUseIntegral];
    [bottomView addSubview:integralL];
    
    UIButton *activateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    activateButton.frame = CGRectMake(kScreenWidth - ALD(100), 0, ALD(100), ALD(44));

    [activateButton setTitle:@"激活" forState:UIControlStateNormal];
    activateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [activateButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    activateButton.backgroundColor = WJColorMainColor;
    activateButton.titleLabel.font = WJFont14;
    
    [activateButton addTarget:self action:@selector(activateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:activateButton];
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
    self.activationListManager.shouldCleanData = YES;
    self.activationListManager.firstPageNo = 1;
    [self.activationListManager loadData];
}

#pragma mark - WJRefreshTableView Delegate

- (void)startHeadRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.activationListManager.shouldCleanData = YES;
        [self requestData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshTableView *)tableView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.activationListManager.shouldCleanData = NO;
        [self.activationListManager loadData];
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
    if ([manager isKindOfClass:[APIServiceCenterActivationListManager class]]) {
        
        self.activateListModel = [manager fetchDataWithReformer:[[WJServiceCenterActivateReformer alloc] init]];
        
        if (self.listArray.count == 0) {
            
            self.listArray =  self.activateListModel.listArray;
            
        } else {
            
            if (self.activationListManager.firstPageNo < self.activateListModel.totalPage) {
                
                [self.listArray addObjectsFromArray: self.activateListModel.listArray];
            }
        }
        
        [self UISetup];
        
        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
        
    } else {
        
        ALERT(@"激活成功");
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIServiceCenterActivationListManager class]]) {
        
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
            
            [self refreshFooterStatus:self.activationListManager.hadGotAllData];
            [self endGetData:NO];
            
        }
        
    } else {
        
        [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
    }
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.listArray.count == 0 || self.listArray == nil) {
        return 0;
    } else {
        return self.listArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(44);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = WJColorWhite;
    
    UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(30), 0, (kScreenWidth - ALD(50))/3, ALD(44))];
    timeL.textColor = WJColorDardGray3;
    timeL.textAlignment = NSTextAlignmentCenter;
    timeL.text = @"提交时间";
    timeL.font = WJFont15;
    
    
    UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake(timeL.right, 0, timeL.width, ALD(44))];
    detailL.text = @"用户编号";
    detailL.textColor = WJColorDardGray3;
    detailL.font = WJFont15;
    detailL.textAlignment = NSTextAlignmentCenter;
    
    
    
    UILabel *integralChangeL = [[UILabel alloc] initWithFrame:CGRectMake(detailL.right, 0, timeL.width, ALD(44))];
    integralChangeL.text = @"积分";
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
    
    WJConsumerActivateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPaymentIdentifier"];
    
    if (cell == nil) {
        cell = [[WJConsumerActivateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectPaymentIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    
    [cell conFigDataWithModel:self.listArray[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJServiceCenterActivateModel *model = self.listArray[indexPath.row];
    
    if (model.isSelect) {
        model.isSelect = NO;
        
    } else {
        
        model.isSelect = YES;
    }
    [self.tableView reloadData];
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        for (WJServiceCenterActivateModel *activateModel in self.listArray) {
            
            if (activateModel.isSelect) {
                
                [self.integralIdlist addObject:activateModel.integralId];
            }
        }
    
        
        self.integralIdStr = [self.integralIdlist componentsJoinedByString:@","];
        
        if (self.integralIdlist.count <= 0) {
            ALERT(@"请选择激活用户");
            return;
        }

        self.serviceCenterActivateManager.integralIds = self.integralIdStr;
        [self.serviceCenterActivateManager loadData];
    }
}


#pragma mark - Action
-(void)activateButtonAction
{
    NSString *message = [NSString stringWithFormat:@"当前激活需红积分%@，可用积分%@是否确认激活?",self.activateListModel.redIntegral,self.activateListModel.canUseIntegral];
    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"激活信息" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
    [alertView showIn];
}

#pragma mark - 属性方法
- (WJRefreshTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(NSMutableArray *)integralIdlist
{
    if (!_integralIdlist) {
        _integralIdlist = [NSMutableArray array];
    }
    return _integralIdlist;
}

-(APIServiceCenterActivationListManager *)activationListManager
{
    if (!_activationListManager) {
        _activationListManager = [[APIServiceCenterActivationListManager alloc] init];
        _activationListManager.delegate = self;
    }
    return _activationListManager;
}

-(APIServiceCenterActivateManager *)serviceCenterActivateManager
{
    if (!_serviceCenterActivateManager) {
        _serviceCenterActivateManager = [[APIServiceCenterActivateManager alloc] init];
        _serviceCenterActivateManager.delegate = self;
    }
    _serviceCenterActivateManager.redIntegral = self.activateListModel.redIntegral;
    _serviceCenterActivateManager.useIntegral = self.activateListModel.canUseIntegral;

    return _serviceCenterActivateManager;
}

@end
