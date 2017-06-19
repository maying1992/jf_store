//
//  WJAllTypeIntegralModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAllTypeIntegralModel.h"

@implementation WJAllTypeIntegralModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.canUseIntegral = ToString(dic[@"integral_usable"]);
        self.waitUseIntegral = ToString(dic[@"integral_freeze"]);
        self.shopIntegral = ToString(dic[@"integral_shopping"]);
        self.shareIntegral = ToString(dic[@"integral_share"]);
        self.multifunctionalIntegral = ToString(dic[@"integral_multifunctional"]);
        self.redIntegral = ToString(dic[@"integral_red"]);
        self.doubleTotalIntegral = ToString(dic[@"doubly_total"]);
        self.operationStatus = [dic[@"operation_status"] integerValue];
        
        
    }
    return self;
}
@end
