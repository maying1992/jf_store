//
//  WJGoodsListReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsListReformer.h"
#import "WJGoodsModel.h"

@implementation WJGoodsListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in data[@"goods_list"]) {
        WJGoodsModel *categoryModel = [[WJGoodsModel alloc] initWithDic:dic];
        [array addObject:categoryModel];
    }
    
    return array;
}

@end
