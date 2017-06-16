//
//  WJStoreModel.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJStoreModel.h"

@implementation WJStoreModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.storeName = ToString(dic[@"storeName"]);
        self.storeNotice = ToString(dic[@"storeNotice"]);
        self.phone = ToString(dic[@"phone"]);
        self.region = ToString(dic[@"region"]);
        self.address = ToString(dic[@"address"]);
    }
    return self;
}
@end
