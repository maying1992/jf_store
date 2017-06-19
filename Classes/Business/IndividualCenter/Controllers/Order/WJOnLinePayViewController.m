//
//  WJOnLinePayViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/25.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOnLinePayViewController.h"
#import "WJRechargeCenterCell.h"
@interface WJOnLinePayViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    UILabel     *totalAmountL;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,assign)NSInteger                selectPayAwayIndex;

@end

@implementation WJOnLinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线支付";
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

//#pragma mark - APIManagerCallBackDelegate
//- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
//{
//    if ([manager isKindOfClass:[APIPayMentManager class]]) {
//        NSDictionary *dic = [manager fetchDataWithReformer:nil];
//        if ([self.payMentManager.payType isEqualToString:@"1"]) {
//            [AlipayManager alipayManager].selectPaymentVC = self;
//            [AlipayManager alipayManager].totleCash = dic[@"order_total"];
//            [[AlipayManager alipayManager]callAlipayWithOrderString:dic[@"prepayid"]];
//        }else if ([self.payMentManager.payType isEqualToString:@"2"]){
//            [WeixinPayManager WXPayManager].selectPaymentVC = self;
//            [WeixinPayManager WXPayManager].totleCash = dic[@"order_total"];
//            [[WeixinPayManager WXPayManager]callWexinPayWithPrePayid:dic[@"prepayid"]];
//        }
//    }
//}
//
//- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
//{
//    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
//}

#pragma mark - Action
-(void)payButtonAction
{
//    if (self.orderModel.payType == 1) {
    
        //微信
//        self.payMentManager.payType = @"1";

        
//    } else {
        //支付宝
//        self.payMentManager.payType = @"2";
//    }
    
    //    [self.payMentManager loadData];
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
//    
//    for (UIView *subView in cell.contentView.subviews)
//    {
//        [subView removeFromSuperview];
//    }
//    
  
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"微信支付";
        
        if (indexPath.row == self.selectPayAwayIndex) {
            [cell conFigData:YES];
        }else{
            [cell conFigData:NO];
        }
        
        
    } else {
        
        cell.textLabel.text = @"支付宝支付";
        
        if (indexPath.row == self.selectPayAwayIndex) {
            [cell conFigData:YES];
        }else{
            [cell conFigData:NO];
        }
        
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

@end
