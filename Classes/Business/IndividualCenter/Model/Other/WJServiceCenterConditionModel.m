//
//  WJServiceCenterConditionModel.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJServiceCenterConditionModel.h"

@implementation WJServiceCenterConditionModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self == [super init])
    {
        self.amount = ToString(dic[@"recharge_amount"]);
        
        self.freezeIntegral = ToString(dic[@"freeze_integral"]);
        self.integralStandard = ToString(dic[@"integral_standard"]);
        
        self.member = ToString(dic[@"member"]);
        self.memberStandard = ToString(dic[@"member_standard"]);
        self.memberIntegralStandard = ToString(dic[@"mem_integral_std"]);
        
    }
    return self;
}
@end
