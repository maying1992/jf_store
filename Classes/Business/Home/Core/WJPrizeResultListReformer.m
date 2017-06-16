//
//  WJPrizeResultListReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPrizeResultListReformer.h"
#import "WJPrizeResultListModel.h"

@implementation WJPrizeResultListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableArray  * array = [NSMutableArray array];
    for (NSDictionary * dic in data[@"prizeWin_list"]) {
        WJPrizeResultListModel * categoryModel = [[WJPrizeResultListModel alloc] initWithDic:dic];
        [array addObject:categoryModel];
    }
    return array;
}

@end
