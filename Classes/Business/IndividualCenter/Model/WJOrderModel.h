//
//  WJOrderModel.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderModel : NSObject
@property(nonatomic,strong) NSString        *orderNo;
@property(nonatomic,assign) OrderStatus     orderStatus;
@property(nonatomic,strong) NSString        *shopName;
@property(nonatomic,strong) NSString        *shopId;
@property(nonatomic,strong)NSMutableArray   *productList;

@property(nonatomic,assign) NSInteger       totalCount;        //合计数量
@property(nonatomic,strong) NSString        *PayAmount;        //列表合计
@property(nonatomic,strong) NSString        *freight;          //运费
@property(nonatomic,strong) NSString        *totalMoney;       //详情总金额
@property(nonatomic,strong) NSString        *totalIntegral;    //详情总积分
@property(nonatomic,strong) NSString        *payTime;
@property(nonatomic,strong) NSString        *createTime;
@property(nonatomic,strong) NSString        *address;             //地址
@property(nonatomic,strong) NSString        *receiveName;         //收件人
@property(nonatomic,strong) NSString        *phone;
@property(nonatomic,assign) NSInteger  payType;//支付方式：1，微信；2，支付宝；3，积分；4，积分+微信；5，积分+支付宝
@property(nonatomic,strong) NSString        *refundReason;   //退款原因





@property(nonatomic,strong) NSString        *refundTime;
@property(nonatomic,strong) NSString        *refundId;

//新
@property(nonatomic,strong) NSString             *chargeCredits;  //充值积分
@property(nonatomic,assign) IndividualOrderType  individualOrderType; //个人中心订单类型
@property(nonatomic,strong) NSString             *orderType;      //订单类型 充值 、赠送、隔代取筹
@property(nonatomic,strong) NSString             *remainingRefundTime;     //退款剩余时间

- (id)initWithDic:(NSDictionary *)dic;
@end
