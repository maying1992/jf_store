//
//  WJIntegralListModel.m
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralListModel.h"
#import "WJIntegralModel.h"
@implementation WJIntegralListModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.totalPage = [dic[@"total_page"] integerValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *orderDic in dic[@"order_list"]) {
            WJIntegralModel *integralModel = [[WJIntegralModel alloc] initWithDic:orderDic];
            [arr addObject:integralModel];
        }
        self.integralList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
