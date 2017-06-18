//
//  WJOrderDetailModel.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderDetailModel.h"
#import "WJShopModel.h"
@implementation WJOrderDetailModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.orderNo = ToString(dic[@"order_code"]);
        self.receiveName = ToString(dic[@"consignee"]);
        self.address = ToString(dic[@"address"]);
        self.phone = ToString(dic[@"contacts"]);

        self.submitTime = ToString(dic[@"create_date"]);
        self.payTime = ToString(dic[@"pay_time"]);        

        NSMutableArray * resultsArray  = [NSMutableArray array];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSDictionary * result = [NSDictionary dictionary];
            result = [dic objectForKey:@"order_info"];
            for (id obj in result) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    WJShopModel *shopModel = [[WJShopModel alloc] initWithDic:obj];
                    [resultsArray addObject:shopModel];
                }
            }
            self.shopList = [NSMutableArray arrayWithArray:resultsArray];
        }
    }
    return self;
}
@end
