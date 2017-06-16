//
//  WJDeliveryAddressListModel.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJDeliveryAddressListModel.h"
#import "WJDeliveryAddressModel.h"

@implementation WJDeliveryAddressListModel
- (id)initWithDic:(NSDictionary *)dic
{
    self.totalPage = [dic[@"totalPage"] intValue];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *productDic in dic[@"list"]) {
        WJDeliveryAddressModel *addressModel = [[WJDeliveryAddressModel alloc] initWithDic:productDic];
        [arr addObject:addressModel];
    }
    self.addresslistArray = [NSMutableArray arrayWithArray:arr];
    [arr removeAllObjects];
    
    return self;
}

@end
