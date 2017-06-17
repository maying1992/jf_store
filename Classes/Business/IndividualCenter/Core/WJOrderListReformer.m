//
//  WJOrderListReformer.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderListReformer.h"
#import "WJIndividualOrderListModel.h"
@implementation WJOrderListReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJIndividualOrderListModel *orderListModel = [[WJIndividualOrderListModel alloc] initWithDic:data];
    
    return orderListModel;
}
@end
