//
//  WJConsumeModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumeModel.h"

@implementation WJConsumeModel

- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.date = ToString(dic[@"consume_date"]);
        self.desc = ToString(dic[@"consume_desc"]);
        self.integral = ToString(dic[@"consume_total"]);
        self.integralId = ToString(dic[@"integral_id"]);
        
    }
    return self;
}
@end
