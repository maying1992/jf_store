//
//  WJCategoryProductModel.m
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryProductModel.h"

@implementation WJCategoryProductModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.name = ToString(dic[@"goodsName"]);
        self.picUrl = ToString(dic[@"firstPic"]);
        self.price = ToString(dic[@"sellingPrice"]);
        self.sellingIntegral = ToString(dic[@"sellingIntegral"]);
        self.shopName = ToString(dic[@"storeName"]);
        self.district = ToString(dic[@"areaName"]);

    }
    return self;
}
@end
