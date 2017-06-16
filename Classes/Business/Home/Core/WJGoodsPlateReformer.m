//
//  WJGoodsPlateReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsPlateReformer.h"
#import "WJGoodsPlateModel.h"

@implementation WJGoodsPlateReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in data[@"categroy_list"]) {
        WJGoodsPlateModel *categoryModel = [[WJGoodsPlateModel alloc] initWithDic:dic];
        [array addObject:categoryModel];
    }
    return array;
}

@end
