//
//  WJAtrrValueModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAtrrValueModel.h"

@implementation WJAtrrValueModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {

        self.attrName = ToString(dic[@"attr_name"]);
        self.imgUrl = ToString(dic[@"img_url"]);
        self.valueId = ToString(dic[@"value_id"]);
        self.valueName = ToString(dic[@"value_name"]);

    }
    return self;
}

@end
