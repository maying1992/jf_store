//
//  WJLotteryDrawDetailModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawDetailModel.h"

@implementation WJLotteryDrawDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.prizeId = ToString(dic[@"goods_brief"]);
        self.goodsId = ToString(dic[@"goods_id"]);
        self.goodsName = ToString(dic[@"goods_name"]);
        self.integral = ToString(dic[@"integral"]);
        self.picUrl = ToString(dic[@"prize_count"]);
        self.prizeTimes = ToString(dic[@"prize_times"]);
        self.prizeCount = ToString(dic[@"prize_count"]);
        self.linkUrl = ToString(dic[@"link_url"]);
        
        self.picInfoList = [NSMutableArray array];
        if (![dic[@"picInfoList"]isEqualToArray:@[]]) {
            for (NSString * url in dic[@"picInfoList"]) {
                [self.picInfoList addObject:url];
            }
        }
    }
    return self;
}

@end
