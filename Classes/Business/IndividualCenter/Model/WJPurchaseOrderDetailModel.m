//
//  WJPurchaseOrderDetailModel.m
//  jf_store
//
//  Created by reborn on 17/5/11.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPurchaseOrderDetailModel.h"
#import "WJProductModel.h"
@implementation WJPurchaseOrderDetailModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.orderNo = ToString(dic[@"order_id"]);
        self.orderStatus = (OrderStatus)[dic[@"status"] integerValue];
        self.receiverName = ToString(dic[@"consignee"]);
        self.phoneNumber = ToString(dic[@"contacts"]);
        self.address = ToString(dic[@"address"]);
        self.countDown = [dic[@"order_out_itme"] integerValue];
        
        
        self.amount = ToString(dic[@"order_price"]);
        self.specialAmount = ToString(dic[@"amount"]);
        self.freightAmount = ToString(dic[@"reveling_price"]);
        self.PayAmount = ToString(dic[@"order_total"]);
        self.createTime = ToString(dic[@"create_date"]);
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *productDic in dic[@"list"]) {
            WJProductModel *productModel = [[WJProductModel alloc] initWithDic:productDic];
            [arr addObject:productModel];
        }
        self.productList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
        
    }
    return self;
}
@end
