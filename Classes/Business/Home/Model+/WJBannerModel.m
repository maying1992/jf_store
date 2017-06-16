//
//  WJBannerModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/13.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBannerModel.h"

@implementation WJBannerModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.descriptions = ToString(dic[@"descriptions"]);
        self.linkType = ToString(dic[@"link_type"]);
        self.linkUrl = ToString(dic[@"link_url"]);
        self.picUrl = ToString(dic[@"pic_url"]);
        
    }
    return self;
}

@end
