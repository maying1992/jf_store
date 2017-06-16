//
//  WJLogisticsCompanyModel.m
//  jf_store
//
//  Created by reborn on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLogisticsCompanyModel.h"

@implementation WJLogisticsCompanyModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.logisticsCompanyId = ToString(dic[@"logisticsId"]);
        self.logisticsCompanyName = ToString(dic[@"logisticsName"]);
        
    }
    return self;
}
@end
