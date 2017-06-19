//
//  WJGivingIntegralListModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingIntegralListModel.h"
#import "WJGivingIntegralModel.h"
@implementation WJGivingIntegralListModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.totalPage = [dic[@"total_page"] integerValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *orderDic in dic[@"integral_list"]) {
            WJGivingIntegralModel *givingIntegralModel = [[WJGivingIntegralModel alloc] initWithDic:orderDic];
            [arr addObject:givingIntegralModel];
        }
        self.list = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
