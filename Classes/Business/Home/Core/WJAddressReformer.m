//
//  WJAddressReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAddressReformer.h"
#import "WJAddressModel.h"

@implementation WJAddressReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in data[@"site_info"]) {
        WJAddressModel *categoryModel = [[WJAddressModel alloc] initWithDic:dic];
        [array addObject:categoryModel];
    }
    
    return array;
}

@end
