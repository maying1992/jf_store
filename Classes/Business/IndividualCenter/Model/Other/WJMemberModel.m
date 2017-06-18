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
        self.name             = ToString(dic[@"user_name"]);
        self.friendsCount   = [dic[@"friend_count"] integerValue];
        self.headPic             = ToString(dic[@"head_pic"]);
        self.userCode             = ToString(dic[@"user_code"]);
        self.remuneration      = [dic[@"remuneration"] integerValue];


        self.number         = [dic[@"number"] integerValue];
    }
    return self;
}
@end
