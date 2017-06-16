//
//  WJCategoryListModel.m
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryListModel.h"

@implementation WJCategoryListModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.categoryId = ToString(dic[@"category_id"]);
        self.categoryName = ToString(dic[@"category_name"]);
    }
    return self;
}
@end
