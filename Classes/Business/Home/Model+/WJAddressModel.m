//
//  WJAddressModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAddressModel.h"

@implementation WJAddressModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.siteId = ToString(dic[@"site_id"]);
        self.siteName = ToString(dic[@"site_name"]);
    }
    return self;
}

@end
