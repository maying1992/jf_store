//
//  WJGoodsDetailReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsDetailReformer.h"
#import "WJGoodsDetailModel.h"

@implementation WJGoodsDetailReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJGoodsDetailModel * categoryModel = [[WJGoodsDetailModel alloc] initWithDic:data];
    return categoryModel;
}

@end
