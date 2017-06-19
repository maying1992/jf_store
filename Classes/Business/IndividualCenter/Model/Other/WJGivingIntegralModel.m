//
//  WJGivingIntegralModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingIntegralModel.h"

@implementation WJGivingIntegralModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.integral = ToString(dic[@"integral"]);
        self.integralId = ToString(dic[@"integral_id"]);
        self.startTime = ToString(dic[@"start_date"]);
        self.endTime = ToString(dic[@"end_date"]);
        self.remark = ToString(dic[@"remark"]);

        self.isDoubly = [dic[@"is_doubly"] integerValue];
    }
    return self;
}
@end
