//
//  WJLotteryDrawDetailReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawDetailReformer.h"
#import "WJLotteryDrawDetailModel.h"

@implementation WJLotteryDrawDetailReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJLotteryDrawDetailModel * categoryModel = [[WJLotteryDrawDetailModel alloc] initWithDic:data];
    return categoryModel;
}

@end
