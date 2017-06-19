//
//  WJOrderIntegralListModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderIntegralListModel.h"

@implementation WJOrderIntegralListModel

- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.integralMultiple = ToString(dic[@"integral_multiple"]);
        self.integralType = ToString(dic[@"integral_type"]);
    }
    return self;
}

@end
