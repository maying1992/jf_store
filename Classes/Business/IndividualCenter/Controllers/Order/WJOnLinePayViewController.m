//
//  WJOnLinePayViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/25.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOnLinePayViewController.h"
#import "WJRechargeCenterCell.h"
#import "APIPaymentManager.h"
#import "AlipayManager.h"
#import "WeixinPayManager.h"

@interface WJOnLinePayViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    UILabel     *totalAmountL;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,assign)NSInteger                selectPayAwayIndex;
@property(nonatomic,strong)APIPaymentManager        * paymentManager;

@end

@implementation WJOnLinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线支付";
    _selectPayAwayIndex = 0;
    self.isHiddenTabBar = YES;
    [self setUI];
    [self.view addSubview:self.tableView];
}

-(void)setUI
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavigationBarHeight - ALD(64), kScreenWidth, ALD(64))];
    bottomView.backgroundColor = WJColorWhite;
    bottomView.layer.borderWidth = 0.5f;
    bottomView.layer.borderColor =  WJColorSeparatorLine.CGColor;
    [self.view addSubview:bottomView];
    
    totalAmountL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), kScreenWidth - ALD(12) - ALD(160) - ALD(24), ALD(30))];
    totalAmountL.font = WJFont13;
    totalAmountL.textAlignment = NSTextAlignmentLeft;
    
    NSString *totalAmountStr = [NSString stringWithFormat:@"总计: %@",self.onlinePayModel.orderTotal];
    totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
    [bottomView addSubview:totalAmountL];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(bottomView.width - ALD(100),0, ALD(100), ALD(64));
    [payButton setTitle:@"支付" forState:UIControlStateNormal];
    [payButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    payButton.titleLabel.font = WJFont14;
    payButton.backgroundColor = WJColorMainColor;
    [payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payButton];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary *dic = [manager fetchDataWithReformer:nil];
    if (self.selectPayAwayIndex  == 0) {
        [[AlipayManager alipayManager] callAlipayWithOrderString:dic[@"order_total"] NowController:self TotleCash:dic[@"order_total"]];
    }else{
        [[WeixinPayManager WXPayManager] callWexinPayWithPrePayid:dic[@"order_total"] NowController:self TotleCash:dic[@"order_total"]];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
}

#pragma mark - Action
-(void)payButtonAction
{
    if (self.selectPayAwayIndex  == 0) {
        //微信
        self.paymentManager.payType = @"2";
    } else {
        //支付宝
        self.paymentManager.payType = @"1";
    }
    
    [self.paymentManager loadData];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJRechargeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseOrderDetailCellIdentifier"];
    
    if (cell == nil) {
        cell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    if (indexPath.row == self.selectPayAwayIndex) {
        [cell conFigData:YES];
    }else{
        [cell conFigData:NO];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"微信支付";
    } else {
        cell.textLabel.text = @"支付宝支付";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectPayAwayIndex = indexPath.row;

    [self.tableView reloadData];
    
}

- (NSAttributedString *)attributedText:(NSString *)text firstLength:(NSInteger)len{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    NSDictionary *attributesForFirstWord = @{
                                             NSFontAttributeName : WJFont12,
                                             NSForegroundColorAttributeName : WJColorDarkGray,
                                             };
    
    NSDictionary *attributesForSecondWord = @{
                                              NSFontAttributeName : WJFont12,
                                              NSForegroundColorAttributeName : WJColorSubColor,
                                              };
    [result setAttributes:attributesForFirstWord
                    range:NSMakeRange(0, len)];
    [result setAttributes:attributesForSecondWord
                    range:NSMakeRange(len, text.length - len)];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - ALD(64)) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (APIPaymentManager *)paymentManager
{
    if (_paymentManager == nil) {
        _paymentManager = [[APIPaymentManager alloc]init];
        _paymentManager.delegate = self;
        _paymentManager.orderId = self.onlinePayModel.orderId;
    }
    return _paymentManager;
}

@end
