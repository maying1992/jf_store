//
//  WJChannelModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/13.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJChannelModel.h"

@implementation WJChannelModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.channelId = ToString(dic[@"channel_id"]);
        self.channelName = ToString(dic[@"channel_name"]);
        self.channelPic = ToString(dic[@"channel_pic"]);
        self.channelType = ToString(dic[@"channel_type"]);
        self.relationType = ToString(dic[@"relation_type"]);
        
    }
    return self;
}

@end
