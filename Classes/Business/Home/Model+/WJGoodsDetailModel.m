//
//  WJGoodsDetailModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsDetailModel.h"

@implementation WJGoodsDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.goodsBrief = ToString(dic[@"goods_brief"]);
        self.goodsId = ToString(dic[@"goods_id"]);
        self.goodsName = ToString(dic[@"goods_name"]);
        self.linkUrl = ToString(dic[@"link_url"]);
        self.address = ToString(dic[@"address"]);
        self.sellingIntegral = ToString(dic[@"selling_integral"]);
        self.sellingPrice = ToString(dic[@"selling_price"]);
        self.logisticsCost = ToString(dic[@"logistics_cost"]);
        self.logisticsIntegral = ToString(dic[@"logistics_integral"]);
        self.salesCount = ToString(dic[@"sales_count"]);
        self.storeId = ToString(dic[@"store_id"]);
        
        self.picList = [NSMutableArray array];
        if (![dic[@"pic_list"]isEqualToArray:@[]]) {
            for (NSString * url in dic[@"pic_list"]) {
                [self.picList addObject:url];
            }
        }
    }
    return self;
}

@end
