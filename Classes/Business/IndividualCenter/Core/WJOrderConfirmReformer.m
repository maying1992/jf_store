//
//  WJOrderConfirmReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderConfirmReformer.h"
#import "WJOnlinePayModel.h"

@implementation WJOrderConfirmReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJOnlinePayModel * onlinePayModel = [[WJOnlinePayModel alloc] initWithDic:data];
    
    return onlinePayModel;
}

@end
