//
//  WJConsumeServiceQueryReformer.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumeServiceQueryReformer.h"
#import "WJServiceCenterQueryModel.h"
@implementation WJConsumeServiceQueryReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJServiceCenterQueryModel *serviceCenterQueryModel = [[WJServiceCenterQueryModel alloc] initWithDic:data];
    
    return serviceCenterQueryModel;
}
@end
