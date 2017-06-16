//
//  WJGoodsModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsModel.h"

@implementation WJGoodsModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.brandName = ToString(dic[@"brand_name"]);
        self.goodsId = ToString(dic[@"goods_id"]);
        self.goodsName = ToString(dic[@"goods_name"]);
        self.picUrl = ToString(dic[@"pic_url"]);
        self.sellingIntegral = ToString(dic[@"selling_integral"]);
        self.sellingPrice = ToString(dic[@"selling_price"]);

    }
    return self;
}


@end
