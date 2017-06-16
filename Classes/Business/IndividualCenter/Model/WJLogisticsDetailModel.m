//
//  WJLogisticsDetailModel.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLogisticsDetailModel.h"

@implementation WJLogisticsDetailModel

- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.context = ToString(dic[@"context"]);
        self.time = ToString(dic[@"time"]);
        
    }
    return self;
}
@end
