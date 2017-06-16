//
//  WJLotteryDrawListModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawListModel.h"

@implementation WJLotteryDrawListModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.prizeId = ToString(dic[@"prize_id"]);
        self.goodsId = ToString(dic[@"goods_id"]);
        self.goodsName = ToString(dic[@"goods_name"]);
        self.picUrl = ToString(dic[@"pic_url"]);
        self.integral = ToString(dic[@"integral"]);
        self.prizeTimes = ToString(dic[@"prize_times"]);
        self.prizeCount = ToString(dic[@"prize_count"]);
    }
    return self;
}

@end
