//
//  APICommonParamsGenerator.m
//  LESports
//
//  Created by ZhangQibin on 15/6/22.
//  Copyright (c) 2015年 LETV. All rights reserved.
//

#import "APICommonParamsGenerator.h"
#import <UIKit/UIKit.h>


@implementation APICommonParamsGenerator

+ (NSDictionary *)commonParamsDictionary
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary: @{}];
    //时间挫
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary  *userInformation = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    parameters[@"user_id"] = userInformation[@"user_id"] ?:@"";
    parameters[@"site_id"] = SITE_ID?:@"";
    parameters[@"sign_type"] = @"MD5";
    parameters[@"channel"] = KChannel;
    parameters[@"timestamp"] = currentTimeString;
    parameters[@"system_id"] = @"12";
    parameters[@"version"] = kSystemVersion;
    parameters[@"terminal"] = @"11";
    
    return parameters;
}



@end
