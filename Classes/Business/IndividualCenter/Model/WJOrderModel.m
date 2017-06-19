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
        
        self.shopName = ToString(dic[@"store_name"]);
        self.shopId = ToString(dic[@"store_id"]);
        
        NSMutableArray * resultsArray  = [NSMutableArray array];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary * result = [NSDictionary dictionary];
            result = [dic objectForKey:@"goods_list"];
            for (id obj in result) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    WJProductModel *productModel = [[WJProductModel alloc] initWithDic:obj];
                    [resultsArray addObject:productModel];
                }
            }
            self.productList = [NSMutableArray arrayWithArray:resultsArray];
        }

//        self.orderNo = ToString(dic[@"order_code"]);
//        self.orderNo = ToString(dic[@"order_id"]);
//        self.orderStatus = (OrderStatus)[dic[@"status"] intValue];
//        self.freight = ToString(dic[@"logistics_cost"]);
//        self.freightIntegral = ToString(dic[@"logistics_integral"]);
//        self.totalCount = [dic[@"goods_num"] integerValue];
//        self.payType = [dic[@"payType"] integerValue];
//        self.refundReason = ToString(dic[@"cancelReason"]);
//
//
//        self.refundTime = ToString(dic[@"refund_time"]);
//        self.refundId = ToString(dic[@"refund_id"]);
//        self.individualOrderType = (IndividualOrderType)[dic[@"individualOrderType"] intValue];
//        self.remainingRefundTime = ToString(dic[@"remainingRefundTime"]);

        }
    return self;
}
@end
