//
//  WJLogisticsDetailViewController.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLogisticsDetailViewController.h"
#import "WJLogisticsDetailModel.h"
#import "WJLogisticsModel.h"
#import "WJLogisticsCell.h"
@interface WJLogisticsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isFirst;
    BOOL isLast;
}

@property(nonatomic,strong)WJRefreshTableView       *tableView;
//@property(nonatomic,strong)APIQueryLogisticsManager *logisticsManager;
@property(nonatomic,strong)WJLogisticsModel         *logisticsModel;
@property(nonatomic,strong)NSArray                  *dataArray;
@end

@implementation WJLogisticsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"物流详情";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
//    [self showLoadingView];
//    [self.logisticsManager loadData];
    
    WJLogisticsModel *logisticsModel = [[WJLogisticsModel alloc] init];
    logisticsModel.orderNo = @"884860725147752190";
    logisticsModel.logisticsName = @"圆通速递";
    logisticsModel.logisticsPhone = @"暂无";
    
    WJLogisticsDetailModel *model1 = [[WJLogisticsDetailModel alloc] init];
    model1.context = @"您的订单开始处理";
    model1.time = @"2017-04-24 11:45:44";
    
    WJLogisticsDetailModel *model2 = [[WJLogisticsDetailModel alloc] init];
    model2.context = @"您的订单待配货";
    model2.time = @"2017-04-25 10:45:44";
    
    logisticsModel.listArray = [NSMutableArray arrayWithObjects:model1,model2, nil];
    
    self.logisticsModel =  logisticsModel;
    self.dataArray = self.logisticsModel.listArray;
    
    [self initTopView];
    [self.tableView reloadData];
}

-(void)initTopView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(95))];
    bgView.backgroundColor = WJColorWhite;
    
    UIImageView *companyIV =[[UIImageView alloc] initWithFrame:CGRectMake(ALD(12), ALD(12), ALD(60), ALD(60))];
    companyIV.backgroundColor = [UIColor redColor];
    
    
    UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(companyIV.right + ALD(10), ALD(10), kScreenWidth - ALD(12), ALD(20))];
    statusL.textColor = WJColorLightGray;
    statusL.attributedText = [self attributedText:[NSString stringWithFormat:@"物流状态: %@",@"运输中"] firstLength:5 lastColor:WJColorMainColor];
    
    UILabel *expressSourceL = [[UILabel alloc] initWithFrame:CGRectMake(companyIV.right + ALD(10), statusL.bottom, kScreenWidth - ALD(12), ALD(20))];
    expressSourceL.textColor = WJColorLightGray;
    expressSourceL.text = [NSString stringWithFormat:@"承运来源: %@",self.logisticsModel.logisticsName];
    
    UILabel *orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(expressSourceL.origin.x, expressSourceL.bottom, kScreenWidth - ALD(12), ALD(20))];
    orderNoL.textColor = WJColorLightGray;
    orderNoL.text = [NSString stringWithFormat:@"订单编号: %@",self.logisticsModel.orderNo];

    
    UILabel *officialTelePhoneL = [[UILabel alloc] initWithFrame:CGRectMake(orderNoL.origin.x, orderNoL.bottom, kScreenWidth - ALD(12), ALD(20))];
    officialTelePhoneL.textColor = WJColorLightGray;
    officialTelePhoneL.text = [NSString stringWithFormat:@"官方电话: %@",self.logisticsModel.logisticsPhone];

    [bgView addSubview:companyIV];
    [bgView addSubview:statusL];
    [bgView addSubview:orderNoL];
    [bgView addSubview:expressSourceL];
    [bgView addSubview:officialTelePhoneL];
    
    self.tableView.tableHeaderView = bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - APIManagerCallBackDelegate
//- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
//{
//    [self hiddenLoadingView];
//    if ([manager isKindOfClass:[APIQueryLogisticsManager class]]) {
//        
//        self.logisticsModel  = [manager fetchDataWithReformer:[[WJLogisticsReformer alloc] init]];
//        self.dataArray = self.logisticsModel.listArray;
//        [self initTopView];
//        [self.tableView reloadData];
//    }
//    
//}
//
//- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
//{
//    
//}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray == nil || self.dataArray.count == 0) {
        return 0;
    } else {
        return self.dataArray.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    WJLogisticsDetailModel *model = self.dataArray[self.dataArray.count - 1 - indexPath.row];
    //    NSString *content = [NSString stringWithFormat:@"%@ %@",model.context,model.time];
    //    return [WJLogisticsCell cellHeightWithString:content isContentHeight:NO];
    //
    WJLogisticsDetailModel *model = self.dataArray[indexPath.row];
    NSString *content = [NSString stringWithFormat:@"%@ %@",model.context,model.time];
    return [WJLogisticsCell cellHeightWithString:content isContentHeight:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsCellIdentifier"];
    if (!cell) {
        cell = [[WJLogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LogisticsCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(36), 0, ALD(12));
    }
    
    NSInteger index = indexPath.row;
    
    isFirst = index == 0;
    isLast  = index == self.dataArray.count - 1;
    
    //    WJLogisticsDetailModel *model = self.dataArray[self.dataArray.count - 1 - indexPath.row];
    //    NSString *content = [NSString stringWithFormat:@"%@ %@",model.context,model.time];
    
    WJLogisticsDetailModel *model = self.dataArray[indexPath.row];
    NSString *content = [NSString stringWithFormat:@"%@ %@",model.context,model.time];
    
    [cell setDataSource:content isFirst:isFirst isLast:isLast];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSAttributedString *)attributedText:(NSString *)text firstLength:(NSInteger)len lastColor:(UIColor*)lastColor{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    
    NSDictionary *attributesForFirstWord = @{
                                             NSFontAttributeName : WJFont14,
                                             NSForegroundColorAttributeName : WJColorDarkGray,
                                             };
    
    NSDictionary *attributesForSecondWord = @{
                                              NSFontAttributeName : WJFont14,
                                              NSForegroundColorAttributeName : lastColor,
                                              };
    [result setAttributes:attributesForFirstWord
                    range:NSMakeRange(0, len)];
    [result setAttributes:attributesForSecondWord
                    range:NSMakeRange(len, text.length - len)];
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

#pragma mark - setter/getter

-(WJRefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//-(APIQueryLogisticsManager *)logisticsManager
//{
//    if (_logisticsManager == nil) {
//        _logisticsManager = [[APIQueryLogisticsManager alloc] init];
//        _logisticsManager.delegate = self;
//    }
//    _logisticsManager.orderId = self.orderId;
//    return _logisticsManager;
//}




@end
