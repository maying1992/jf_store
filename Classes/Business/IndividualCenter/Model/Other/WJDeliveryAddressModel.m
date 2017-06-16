//
//  WJDeliveryAddressModel.m
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJDeliveryAddressModel.h"

@implementation WJDeliveryAddressModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self == [super init])
    {
        self.name = ToString(dic[@"consignee"]);
        self.phone = ToString(dic[@"contacts"]);
        
        self.provinceName = ToString(dic[@"province"]);
        self.cityName = ToString(dic[@"city"]);
        self.districtName = ToString(dic[@"district"]);
        
        self.address = ToString(dic[@"address"]);
        self.detailAddress = ToString(dic[@"address"]);
        self.isDefaultAddress = [dic[@"isDefault"] boolValue];
        
        self.receivingId = ToString(dic[@"receivingId"]);
        
        self.provinceId = ToString(dic[@"province"]);
        self.cityId = ToString(dic[@"city"]);
        self.districtId = ToString(dic[@"district"]);
        
        
    }
    return self;
}

@end
