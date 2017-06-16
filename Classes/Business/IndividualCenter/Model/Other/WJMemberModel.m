//
//  WJMemberModel.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMemberModel.h"

@implementation WJMemberModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name             = ToString(dic[@"name"]);
        self.number         = [dic[@"number"] integerValue];
        
    }
    return self;
}
@end
