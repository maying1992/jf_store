//
//  WJSystemMessageModel.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSystemMessageModel.h"

@implementation WJSystemMessageModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title               = ToString(dic[@"message_title"]);
        self.content             = ToString(dic[@"message_content"]);
        self.date                = ToString(dic[@"update_date"]);
        self.time                = ToString(dic[@"update_date"]);
        self.orderNo             = ToString(dic[@"orderNo"]);
        self.imgUrl              = ToString(dic[@"head_pic"]);
        self.messageId           = ToString(dic[@"message_id"]);
        self.messageType         = [dic[@"mess_type"] integerValue];
        
    }
    return self;
}

@end
