//
//  WJTradeHallfeeReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradeHallfeeReformer.h"
#import "WJAdmissionModel.h"

@implementation WJTradeHallfeeReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];

    NSMutableArray  * array = [NSMutableArray array];
    for (NSDictionary * dic in data[@"admission_list"]) {
        WJAdmissionModel * categoryModel = [[WJAdmissionModel alloc] initWithDic:dic];
        [array addObject:categoryModel];
    }
    NSString * isPay = ToString(data[@"is_pay"]);
    [dataDic setValue:isPay forKey:@"is_pay"];
    [dataDic setValue:array forKey:@"admission_list"];
    return dataDic;
}

@end
