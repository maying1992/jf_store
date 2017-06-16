//
//  WJOrderModel.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderModel.h"
#import "WJProductModel.h"

@implementation WJOrderModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.orderNo = ToString(dic[@"orderCode"]);
        self.shopName = ToString(dic[@"storeName"]);
        self.orderStatus = (OrderStatus)[dic[@"status"] intValue];
        self.PayAmount = ToString(dic[@"orderTotal"]);
        self.freight = ToString(dic[@"logistics"]);
        self.totalMoney = ToString(dic[@"totalMoney"]);
        self.totalIntegral = ToString(dic[@"totalIntegral"]);
        self.totalCount = [dic[@"goods_num"] integerValue];
        self.payTime = ToString(dic[@"payTime"]);
        self.createTime = ToString(dic[@"createDate"]);
        self.address = ToString(dic[@"address"]);
        self.receiveName = ToString(dic[@"consignee"]);
        self.phone = ToString(dic[@"contacts"]);
        self.payType = [dic[@"payType"] integerValue];
        self.refundReason = ToString(dic[@"cancelReason"]);



        
        self.shopId = ToString(dic[@"store_id"]);
        self.refundTime = ToString(dic[@"refund_time"]);
        self.refundId = ToString(dic[@"refund_id"]);
        self.individualOrderType = (IndividualOrderType)[dic[@"individualOrderType"] intValue];
        self.remainingRefundTime = ToString(dic[@"remainingRefundTime"]);

        
        NSMutableArray * resultsArray  = [NSMutableArray array];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary * result = [NSDictionary dictionary];
            result = [dic objectForKey:@"detailList"];
            for (id obj in result) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    WJProductModel *productModel = [[WJProductModel alloc] initWithDic:obj];
                    [resultsArray addObject:productModel];
                }
            }
            self.productList = [NSMutableArray arrayWithArray:resultsArray];
        }
    }
    return self;
}
@end
