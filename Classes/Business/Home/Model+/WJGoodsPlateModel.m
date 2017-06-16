//
//  WJGoodsPlateModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsPlateModel.h"

@implementation WJGoodsPlateModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.categroyId = ToString(dic[@"category_id"]);
        self.categroyName = ToString(dic[@"category_name"]);
        self.picUrl = ToString(dic[@"pic_url"]);
    }
    return self;
}

@end
