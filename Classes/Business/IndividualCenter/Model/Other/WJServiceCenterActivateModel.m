//
//  WJServiceCenterActivateModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJServiceCenterActivateModel.h"

@implementation WJServiceCenterActivateModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self == [super init])
    {

        self.submitTime = ToString(dic[@"activation_date"]);
        self.userCode = ToString(dic[@"user_code"]);
        self.integral = ToString(dic[@"integral"]);
        self.integralId = ToString(dic[@"integral_id"]);
        
    }
    return self;
}
@end
