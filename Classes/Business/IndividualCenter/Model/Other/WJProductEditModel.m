//
//  WJProductEditModel.m
//  jf_store
//
//  Created by reborn on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJProductEditModel.h"

@implementation WJProductEditModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self == [super init])
    {
        self.category = ToString(dic[@"category"]);
        self.integral = ToString(dic[@"integral"]);
        self.stock = ToString(dic[@"stock"]);
        
        self.freight = ToString(dic[@"freight"]);
        self.standard = ToString(dic[@"standard"]);
        
        self.limitCount = ToString(dic[@"limitCount"]);
        
    }
    return self;
}

@end
