//
//  WJServiceCenterActivateReformer.m
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJServiceCenterActivateReformer.h"
#import "WJServiceCenterActivateListModel.h"
@implementation WJServiceCenterActivateReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJServiceCenterActivateListModel *activateListModel = [[WJServiceCenterActivateListModel alloc] initWithDic:data];
    
    return activateListModel;
}
@end
