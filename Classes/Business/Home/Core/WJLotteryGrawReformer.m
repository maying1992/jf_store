//
//  WJLotteryGrawReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryGrawReformer.h"
#import "WJLotteryDrawListModel.h"

@implementation WJLotteryGrawReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableArray  * array = [NSMutableArray array];
    for (NSDictionary * dic in data[@"goods_list"]) {
        WJLotteryDrawListModel * categoryModel = [[WJLotteryDrawListModel alloc] initWithDic:dic];
        [array addObject:categoryModel];
    }
    return array;
}

@end
