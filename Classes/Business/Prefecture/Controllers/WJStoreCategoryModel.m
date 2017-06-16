//
//  WJStoreCategoryModel.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJStoreCategoryModel.h"

@implementation WJStoreCategoryModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.categoryName = ToString(dic[@"categoryName"]);
        self.categoryId = ToString(dic[@"categoryId"]);
    }
    return self;
}
@end
