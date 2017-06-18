//
//  WJShopModel.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJShopModel.h"
#import "WJProductModel.h"
@implementation WJShopModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.shopName = ToString(dic[@"store_name"]);
        self.shopId = ToString(dic[@"store_id"]);

        self.orderStatus = (OrderStatus)[dic[@"status"] intValue];
        
        self.payPrice = ToString(dic[@"total_price"]);
        self.payIntegral = ToString(dic[@"total_integral"]);
    
        self.freight = ToString(dic[@"logistics_cost"]);
        self.freightIntegral = ToString(dic[@"logistics_integral"]);

        
        NSMutableArray * resultsArray  = [NSMutableArray array];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary * result = [NSDictionary dictionary];
            result = [dic objectForKey:@"goods_list"];
            for (id obj in result) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    WJProductModel *productModel = [[WJProductModel alloc] initWithDic:obj];
                    [resultsArray addObject:productModel];
                }
            }
            self.productList = [NSMutableArray arrayWithArray:resultsArray];
        }
    }
    return self;
}
@end
