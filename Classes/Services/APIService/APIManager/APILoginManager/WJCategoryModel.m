//
//  WJCategoryModel.m
//  jf_store
//
//  Created by reborn on 17/5/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryModel.h"
#import "WJCategoryListModel.h"
#import "WJCategoryProductModel.h"
@implementation WJCategoryModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.totalPage = [dic[@"totalPage"] integerValue];

        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *orderDic in dic[@"category_list"]) {
            WJCategoryListModel *categoryListModel = [[WJCategoryListModel alloc] initWithDic:orderDic];
            [arr addObject:categoryListModel];
        }
        self.categoryList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
        
        for (NSDictionary *orderDic in dic[@"goods"]) {
            WJCategoryProductModel *categoryProductModel = [[WJCategoryProductModel alloc] initWithDic:orderDic];
            [arr addObject:categoryProductModel];
        }
        self.goodsList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
