
//
//  WJAdmissionModel.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAdmissionModel.h"

@implementation WJAdmissionModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.admissionMoney = ToString(dic[@"admission_money"]);
        if ([ToString(dic[@"admission_type"]) isEqualToString:@"1"]) {
            self.admissionType = @"个人";
        }else if ([ToString(dic[@"admission_type"]) isEqualToString:@"2"]){
            self.admissionType = @"企业";
        }
//        self.admissionType = ToString(dic[@"admission_type"]);
    }
    return self;
}

@end
