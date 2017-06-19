//
//  WJServiceCenterQueryModel.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJServiceCenterQueryModel.h"
#import "WJConsumeModel.h"
@implementation WJServiceCenterQueryModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.startTime = ToString(dic[@"start_date"]);
        self.endTime = ToString(dic[@"end_date"]);
        self.redIntegral = ToString(dic[@"red_integral"]);
        self.effective = ToString(dic[@"effective"]);

        self.totalPage = [dic[@"total_page"] integerValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *consumeDic in dic[@"integral_list"]) {
            WJConsumeModel *consumeModel = [[WJConsumeModel alloc] initWithDic:consumeDic];
            [arr addObject:consumeModel];
        }
        self.integralList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
