//
//  WJPaymentModel.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPaymentModel.h"

@implementation WJPaymentModel

- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.orderId = ToString(dic[@"order_id"]);
        self.orderName = ToString(dic[@"order_name"]);
        self.orderTotal = ToString(dic[@"order_total"]);
        self.payMentType = ToString(dic[@"pay_type"]);
        
    }
    return self;
}

@end
