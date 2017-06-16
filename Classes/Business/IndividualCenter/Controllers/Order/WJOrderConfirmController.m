//
//  WJOrderConfirmController.m
//  jf_store
//
//  Created by reborn on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderConfirmController.h"
#import "WJOrderConfirmModel.h"
#import "WJRechargeCenterCell.h"
#import "WJOrderModel.h"
#import "WJPurchaseOrderCell.h"
#import "WJMyDeliveryAddressViewController.h"
#import "WJPassView.h"
#import "WJSystemAlertView.h"
#import "WJIntegralTradePasswordViewController.h"
@interface WJOrderConfirmController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate,WJSystemAlertViewDelegate,WJPassViewDelegate>
{
    UILabel    *nameL;
    UILabel    *phoneL;
    UILabel    *addressL;
    
    UILabel    *totalAmountL;
    CGFloat    totalOrderAmount;
    CGFloat    totalIntegralAmount;

}
@property(nonatomic,strong)WJOrderConfirmModel      *orderConfirmModel;

@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSArray                  *listArray;

@property(nonatomic,assign)NSInteger                selectPayAwayIndex;

@end

@implementation WJOrderConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    totalOrderAmount = 0;
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.tableView];
    [self initBottomView];
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"refreshMyDeliveryAddress" object:nil];
    
//    [self requestData];
}

-(void)requestData
{
    if (self.orderConfirmFromController == FromPayRightNow) {
        
        //立即购买
        [self showLoadingView];
//        [self.payRightNowManager loadData];
        
    } else {
        
        //购物车
        [self showLoadingView];
//        [self.shopCartSettleManager loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBottomView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight - ALD(49) - kNavBarAndStatBarHeight, kScreenWidth, ALD(49))];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = WJColorSeparatorLine.CGColor;
    bgView.backgroundColor = WJColorTabBar;
    [self.view addSubview:bgView];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(kScreenWidth - ALD(130), 0, ALD(130), bgView.height);
    submitButton.backgroundColor = WJColorMainColor;
    [submitButton setTitle:@"结算" forState:UIControlStateNormal];
    [submitButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    submitButton.titleLabel.font = WJFont16;
    submitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:submitButton];
    
    
    totalAmountL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), (ALD(49) - ALD(25))/2, kScreenWidth - submitButton.width - ALD(15) - ALD(12), ALD(25))];
    totalAmountL.text = [NSString stringWithFormat:@"合计: %@积分%@元 运费: %@",self.orderConfirmModel.orderTotal,self.orderConfirmModel.integralTotal,self.orderConfirmModel.freightTotal];
    totalAmountL.textColor = WJColorDarkGray;
    totalAmountL.font = WJFont15;
    totalAmountL.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:totalAmountL];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.orderConfirmModel.listArray.count == 0 || self.orderConfirmModel.listArray == nil) {
        
        return 0;
    } else {
        
        return self.orderConfirmModel.listArray.count + 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
        
    } else if (section == 1) {
        
        return 3;
        
    } else {
        
        WJOrderModel *order = self.orderConfirmModel.listArray[section - 2];
        
        if (order.productList.count == 0 || order.productList == nil) {
            return 0;
        } else {
            
            return order.productList.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return ALD(100);
        
    } else if (indexPath.section == 1) {
        
        return ALD(44);
        
    } else {
        
        return ALD(130);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        
        return 0;
        
    } else {
        return ALD(40);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.001;
        
    } else if (section == 1) {
        return ALD(15);
        
    } else {
        return ALD(75);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    
    if (section >= 2) {
        
        headerView.backgroundColor = WJColorWhite;
        
        UILabel *shopNameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), ALD(200), ALD(20))];
        shopNameL.textColor = WJColorDarkGray;
        shopNameL.font = WJFont12;
        shopNameL.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:shopNameL];
        
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), ALD(40) - 0.5, kScreenWidth - ALD(24), 0.5)];
        line.backgroundColor = WJColorSeparatorLine;
        [headerView addSubview:line];
        
        WJOrderModel *order = self.orderConfirmModel.listArray[section - 2];
        
        shopNameL.text = order.shopName;
    }
    
    
    return headerView;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    
    if (section >= 2) {
        
        footerView.backgroundColor = WJColorWhite;

        UILabel *totalMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), 0, ALD(150), ALD(30))];
        totalMoneyL.textAlignment = NSTextAlignmentRight;
        [footerView addSubview:totalMoneyL];
        
        
        WJOrderModel *order = self.orderConfirmModel.listArray[section - 2];

        NSString *totalMoneyStr = [NSString stringWithFormat:@"商品小计: %@",order.PayAmount];
        totalMoneyL.attributedText= [self attributedText:totalMoneyStr firstLength:5];
        
        
        UILabel *freightL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), totalMoneyL.bottom, ALD(150), ALD(30))];
        freightL.textAlignment = NSTextAlignmentRight;
        [footerView addSubview:freightL];
    
        NSString *freightStr = [NSString stringWithFormat:@"运费: %@",order.freight];
        freightL.attributedText= [self attributedText:freightStr firstLength:3];
        
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, ALD(75) - ALD(15), kScreenWidth, ALD(15))];
        spaceView.backgroundColor = WJColorViewBg;
        
        [footerView addSubview:spaceView];
        
        return footerView;

        
    }
    
    return footerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        
        if (([self.orderConfirmModel.receiverName isEqualToString:@""] || self.orderConfirmModel.receiverName == nil) && ([self.orderConfirmModel.phoneNumber isEqualToString:@""] || self.orderConfirmModel.phoneNumber == nil) && ([self.orderConfirmModel.address isEqualToString:@""] || self.orderConfirmModel.address == nil)) {
            
            UILabel *noAddessTipL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), (ALD(100) - ALD(20))/2, kScreenWidth - ALD(10), ALD(10))];
            noAddessTipL.textColor = WJColorDardGray9;
            noAddessTipL.font = WJFont14;
            noAddessTipL.text = @"添加邮寄地址";
            [cell.contentView addSubview:noAddessTipL];
            
        } else {
            
            nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), ALD(15), kScreenWidth - ALD(20), ALD(20))];
            nameL.textColor = WJColorMainColor;
            nameL.text = [NSString stringWithFormat:@"收件人:%@",self.orderConfirmModel.receiverName];
            nameL.font = WJFont14;
            [cell.contentView addSubview:nameL];
            
            
            phoneL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.frame.origin.x, nameL.bottom, kScreenWidth - ALD(20), ALD(20))];
            phoneL.textColor = WJColorMainColor;
            phoneL.text = [NSString stringWithFormat:@"手机号: %@",self.orderConfirmModel.phoneNumber];
            phoneL.font = WJFont14;
            [cell.contentView addSubview:phoneL];
            
            
            addressL = [[UILabel alloc] initWithFrame:CGRectMake(phoneL.frame.origin.x,phoneL.bottom, kScreenWidth - ALD(25), ALD(35))];
            addressL.textColor = WJColorMainColor;
            addressL.numberOfLines = 0;
            addressL.text = [NSString stringWithFormat:@"收货地址:%@",self.orderConfirmModel.address];
            addressL.font = WJFont14;
            [cell.contentView addSubview:addressL];
        }
        
        UIImage *image = [UIImage imageNamed:@"icon_arrow_right"];
        UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - image.size.width, (ALD(100) - image.size.height)/2, image.size.width, image.size.height)];
        rightArrowImageView.image = [UIImage imageNamed:@"icon_arrow_right"];
        [cell.contentView  addSubview:rightArrowImageView];
        
    } else if (indexPath.section == 1) {
        
        
        WJRechargeCenterCell *rechargeCenterCell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
        rechargeCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell  = rechargeCenterCell;
        
        if (indexPath.row == 0) {
            
            rechargeCenterCell.textLabel.text = @"可用积分3倍支付";
            
            if (indexPath.row == self.selectPayAwayIndex) {
                [rechargeCenterCell conFigData:YES];
            }else{
                [rechargeCenterCell conFigData:NO];
            }
            
            
        }  else if (indexPath.row == 1) {
            
            rechargeCenterCell.textLabel.text = @"购物积分5倍支付";
            
            if (indexPath.row == self.selectPayAwayIndex) {
                [rechargeCenterCell conFigData:YES];
            }else{
                [rechargeCenterCell conFigData:NO];
            }
            
        } else {
            
            rechargeCenterCell.textLabel.text = @"多功能积分1倍支付";
            
            if (indexPath.row == self.selectPayAwayIndex) {
                [rechargeCenterCell conFigData:YES];
            }else{
                [rechargeCenterCell conFigData:NO];
            }
        }
        
    } else {
        
        WJPurchaseOrderCell *orderCell = [[WJPurchaseOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJPurchaseOrderCellIdentifier"];
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WJOrderModel *order = self.orderConfirmModel.listArray[indexPath.section - 2];
        [orderCell configDataWithProduct:order.productList[indexPath.row]];
        
        cell  = orderCell;
    }
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        WJMyDeliveryAddressViewController *myDeliveryAddressVC = [[WJMyDeliveryAddressViewController alloc] init];
        myDeliveryAddressVC.addressFromVC = fromOrderConfirmVC;
        
        myDeliveryAddressVC.selectAddressBlock = ^(WJDeliveryAddressModel *addressModel){
            
            self.orderConfirmModel.receiverName =  addressModel.name;
            self.orderConfirmModel.phoneNumber = addressModel.phone;
            self.orderConfirmModel.address = addressModel.address;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
//            if (self.orderConfirmFromController == FromPayRightNow) {
//                
//                //立即购买
//                WJOrderShopModel *orderShopModel = [self.orderConfirmModel.shopArray objectAtIndex:0];
//                WJProductModel *productModel =[orderShopModel.productArray firstObject];
//                
//                _payRightNowManager.shopId = orderShopModel.shopId;
//                _payRightNowManager.skuId = productModel.skuId;
//                _payRightNowManager.goodsCount = productModel.count;
//                _payRightNowManager.receiveId = addressModel.receivingId;
//                
//                [self showLoadingView];
//                [_payRightNowManager loadData];
//                
//            } else {
//                
//                //购物车
//                _shopCartSettleManager.receiveId = addressModel.receivingId;
//                [self showLoadingView];
//                [_shopCartSettleManager loadData];
//                
//            }
            
        };
        [self.navigationController pushViewController:myDeliveryAddressVC animated:YES];
        
    } else if (indexPath.section == 1) {
        
        self.selectPayAwayIndex = indexPath.row;

        [self.tableView reloadData];
    }

    
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

#pragma mark - Action
-(void)submitButtonAction
{
    WJPassView *passView  = [[WJPassView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(50)) title:@"请输入支付密码"];
    passView.delegate = self;
    [passView showIn];
    
    
//    if (self.orderConfirmModel.receiverName.length == 0 || self.orderConfirmModel.phoneNumber.length == 0 || self.orderConfirmModel.address.length == 0) {
//        
//        [[TKAlertCenter defaultCenter]  postAlertWithMessage:@"收货信息不全"];
//        
//    } else {
//        
//        if (self.orderConfirmFromController == FromPayRightNow) {
//            
//            //立即购买
//
//            
//        } else {
//            
//            //购物车
//        }
////        [self showLoadingView];
////        [self.submitOrderManager loadData];
//    }
}


#pragma mark - WJPassViewDelegate
- (void)successWithVerifyPsdAlert:(WJPassView *)alertView
{
   
}


- (void)failedWithVerifyPsdAlert:(WJPassView *)alertView errerMessage:(NSString * )errerMessage
{
    [alertView dismiss];
    
    [self showAlertWithMessage:errerMessage];

}

-(void)setTradePasswordActionWith:(WJPassView *)alertView
{
    [alertView dismiss];

    WJIntegralTradePasswordViewController *integralTradePasswordViewController = [[WJIntegralTradePasswordViewController alloc] init];
    [self.navigationController pushViewController:integralTradePasswordViewController animated:YES];
}

- (void)forgetPasswordActionWith:(WJPassView *)alertView
{
    [alertView dismiss];
    
    WJIntegralTradePasswordViewController *integralTradePasswordViewController = [[WJIntegralTradePasswordViewController alloc] init];
    [self.navigationController pushViewController:integralTradePasswordViewController animated:YES];}

#pragma mark - WJSystemAlertViewDelegate
- (void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //取消
    if (buttonIndex == 0) {
        [alertView dismiss];
        
    } else {
        
        WJPassView *passView = [[WJPassView alloc] initWithFrame:self.view.bounds title:@"请输入支付密码"];
        passView.delegate = self;
        [passView showIn];
    }
}



- (void)showAlertWithMessage:(NSString *)msg
{
    WJSystemAlertView *sysAlert = [[WJSystemAlertView alloc] initWithTitle:@"验证失败" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再试一次" textAlignment:NSTextAlignmentCenter];
    
    [sysAlert showIn];
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(49)) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(-ALD(40), 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(WJOrderConfirmModel *)orderConfirmModel
{
    if (!_orderConfirmModel) {
        _orderConfirmModel = [[WJOrderConfirmModel alloc] init];
    }
    _orderConfirmModel.receiverName = @"小名";
    _orderConfirmModel.address = @"京宝大厦";
    _orderConfirmModel.phoneNumber = @"13312330493";
    _orderConfirmModel.orderTotal = @"42324";
    _orderConfirmModel.integralTotal = @"100";
    _orderConfirmModel.freightTotal = @"20";
    
    
    WJProductModel *product1 = [[WJProductModel alloc] init];
    product1.name = @"茶水壶";
    product1.standardDes = @"43mmx56mm";
    product1.count = 1;
    
    WJProductModel *product2 = [[WJProductModel alloc] init];
    product2.name = @"电暖壶";
    product2.standardDes = @"30mmx40mm";
    product2.count = 1;
    
    WJOrderModel *order1 = [[WJOrderModel alloc] init];
    order1.shopName = @"北京阿迪王店铺";
    order1.orderStatus = OrderStatusUnfinished;
    order1.freight = @"34积分";
    order1.PayAmount = @"4323积分";
    
    
    WJOrderModel *order2 = [[WJOrderModel alloc] init];
    order2.shopName = @"耐克店铺";
    order2.orderStatus = OrderStatusUnfinished;
    order2.freight = @"94积分";
    order2.PayAmount = @"223积分";
    
    WJProductModel *product3 = [[WJProductModel alloc] init];
    product3.name = @"保温杯";
    product3.standardDes = @"30mmx40mm";
    product3.count = 1;
    
    order1.productList = [NSMutableArray arrayWithObjects:product1,product2 ,nil];
    order2.productList = [NSMutableArray arrayWithObjects:product3 ,product1,nil];
    
    _orderConfirmModel.listArray = [NSMutableArray arrayWithObjects:order1, order2,nil];
    
    return _orderConfirmModel;
}



@end
