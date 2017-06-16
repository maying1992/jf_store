//
//  WJIndividualCenterReformer.m
//  jf_store
//
//  Created by reborn on 17/5/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualCenterReformer.h"
#import "WJIndividualCenterModel.h"

@implementation WJIndividualCenterReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJIndividualCenterModel *individualCenterModel = [[WJIndividualCenterModel alloc] initWithDic:data];
    
    return individualCenterModel;
}
@end
