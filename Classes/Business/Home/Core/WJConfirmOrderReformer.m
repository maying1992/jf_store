//
//  WJConfirmOrderReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConfirmOrderReformer.h"
#import "WJOrderConfirmModel.h"

@implementation WJConfirmOrderReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJOrderConfirmModel *orderConfirmModel = [[WJOrderConfirmModel alloc] initWithDic:data];
    
    return orderConfirmModel;
}

@end
