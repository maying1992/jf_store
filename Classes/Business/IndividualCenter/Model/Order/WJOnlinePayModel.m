//
//  WJOnlinePayModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOnlinePayModel.h"

@implementation WJOnlinePayModel

- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.accountBalance = ToString(dic[@"account_balance"]);
        self.orderId = ToString(dic[@"order_id"]);
        self.orderIntegral = ToString(dic[@"order_integral"]);
        self.orderName = ToString(dic[@"order_name"]);
        self.orderTotal = ToString(dic[@"order_total"]);
        self.payType = ToString(dic[@"pay_type"]);
        
    }
    return self;
}
@end
