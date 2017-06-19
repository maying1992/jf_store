//
//  WJGivingIntegralListReformer.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingIntegralListReformer.h"
#import "WJGivingIntegralListModel.h"
@implementation WJGivingIntegralListReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJGivingIntegralListModel *givingIntegralListModel = [[WJGivingIntegralListModel alloc] initWithDic:data];
    
    return givingIntegralListModel;
}
@end
