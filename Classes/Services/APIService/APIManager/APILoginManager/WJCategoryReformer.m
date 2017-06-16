//
//  WJCategoryReformer.m
//  jf_store
//
//  Created by reborn on 17/5/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryReformer.h"
#import "WJCategoryModel.h"
@implementation WJCategoryReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJCategoryModel *categoryModel = [[WJCategoryModel alloc] initWithDic:data];
    
    return categoryModel;
}

@end
