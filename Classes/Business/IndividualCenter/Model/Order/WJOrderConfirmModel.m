//
//  WJOrderConfirmModel.m
//  jf_store
//
//  Created by reborn on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderConfirmModel.h"
#import "WJOrderModel.h"
@implementation WJOrderConfirmModel

- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.receiverName = ToString(dic[@"consignee"]);
        self.phoneNumber = ToString(dic[@"contacts"]);
        self.address = ToString(dic[@"address"]);
        self.receivingId = ToString(dic[@"receiving_id"]);
        self.orderTotal = ToString(dic[@"orderTotal"]);
        self.integralTotal = ToString(dic[@"integralTotal"]);


        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *productDic in dic[@"list"]) {
            WJOrderModel *orderModel = [[WJOrderModel alloc] initWithDic:productDic];
            [arr addObject:orderModel];
        }
        self.listArray = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
