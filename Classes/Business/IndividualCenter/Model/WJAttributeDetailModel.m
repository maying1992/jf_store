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
        self.valueName       = ToString(dic[@"value_name"]);
    }
    return self;
}
@end
