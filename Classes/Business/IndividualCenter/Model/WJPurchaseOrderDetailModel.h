//
//  WJPurchaseOrderDetailModel.h
//  jf_store
//
//  Created by reborn on 17/5/11.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJOrderModel.h"

@interface WJPurchaseOrderDetailModel : NSObject
@property(nonatomic,strong)NSString     *orderNo;
@property(nonatomic,assign)OrderStatus  orderStatus;
@property(nonatomic,strong)NSString     *receiverName;
@property(nonatomic,strong)NSString     *phoneNumber;
@property(nonatomic,strong)NSString     *address;
@property(nonatomic,assign)NSInteger    countDown;
@property(nonatomic,strong)NSString     *createTime;

@property(nonatomic,strong)NSString     *amount;             //商品金额
@property(nonatomic,strong)NSString     *specialAmount;      //优惠金额
@property(nonatomic,strong)NSString     *freightAmount;      //运费
@property(nonatomic,strong)NSString     *PayAmount;          //实付款

@property(nonatomic,strong)NSMutableArray   *productList;




//新
@property(nonatomic,strong)NSString      *shopName;


- (id)initWithDic:(NSDictionary *)dic;

@end
