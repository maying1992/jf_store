//
//  WJOrderDetailReformer.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderDetailReformer.h"
#import "WJOrderDetailModel.h"
@implementation WJOrderDetailReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJOrderDetailModel *orderDetailModel = [[WJOrderDetailModel alloc] initWithDic:data];
    
    return orderDetailModel;
}
@end
