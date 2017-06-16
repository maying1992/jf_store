//
//  WJPrizeResultListModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPrizeResultListModel.h"

@implementation WJPrizeResultListModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.prizeNum = ToString(dic[@"prize_num"]);
        self.userName = ToString(dic[@"user_name"]);
        self.goodsName = ToString(dic[@"goods_name"]);
    }
    return self;
}

@end
