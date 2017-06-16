//
//  WJIndividualOrderListModel.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualOrderListModel.h"
#import "WJOrderModel.h"
@implementation WJIndividualOrderListModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.totalPage = [dic[@"totalPage"] integerValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *orderDic in dic[@"list"]) {
            WJOrderModel *orderModel = [[WJOrderModel alloc] initWithDic:orderDic];
            [arr addObject:orderModel];
        }
        self.orderList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
