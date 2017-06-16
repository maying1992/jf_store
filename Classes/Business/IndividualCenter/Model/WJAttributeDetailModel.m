//
//  WJAttributeDetailModel.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAttributeDetailModel.h"

@implementation WJAttributeDetailModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.attributeName   = ToString(dic[@"attr_name"]);
        self.valueId         = ToString(dic[@"value_id"]);
        self.valueName       = ToString(dic[@"value_name"]);
        
        self.price           = ToString(dic[@"selling_price"]);
        self.originalPrice   = ToString(dic[@"market_price"]);
        self.skuId           = ToString(dic[@"sku_id"]);
        self.stock           = ToString(dic[@"goods_number"]);
        
    }
    return self;
}
@end
