//
//  WJIntegralModel.m
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralModel.h"

@implementation WJIntegralModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.remark = dic[@"remark"];
        self.integralNo = dic[@"integral_no"];

        self.tradeType = dic[@"trade_type"];
        self.consumptionType = dic[@"consumption_type"];
        self.returnTime = dic[@"return_date"];
        self.tradeTime = dic[@"trade_date"];
        self.total = dic[@"total"];

    }
    return self;
}
@end
