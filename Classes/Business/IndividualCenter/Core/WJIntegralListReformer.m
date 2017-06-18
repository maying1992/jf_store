//
//  WJIntegralListReformer.m
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIntegralListReformer.h"
#import "WJIntegralListModel.h"
@implementation WJIntegralListReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJIntegralListModel *integralListModel = [[WJIntegralListModel alloc] initWithDic:data];
    
    return integralListModel;
}
@end
