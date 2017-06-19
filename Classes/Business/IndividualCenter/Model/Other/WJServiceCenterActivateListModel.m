//
//  WJServiceCenterActivateListModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJServiceCenterActivateListModel.h"
#import "WJServiceCenterActivateModel.h"
@implementation WJServiceCenterActivateListModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.redIntegral = ToString(dic[@"integral_red"]);
        self.canUseIntegral = ToString(dic[@"integral_use"]);
        self.radio = ToString(dic[@"ratio"]);

        self.totalPage = [dic[@"total_page"] integerValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *orderDic in dic[@"activation_list"]) {
            WJServiceCenterActivateModel *activateModel = [[WJServiceCenterActivateModel alloc] initWithDic:orderDic];
            [arr addObject:activateModel];
        }
        self.listArray = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
