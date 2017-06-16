//
//  WJCategoryModel.h
//  jf_store
//
//  Created by reborn on 17/5/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCategoryModel : NSObject
@property(nonatomic,strong)NSMutableArray *categoryList;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property(nonatomic,assign)NSInteger      totalPage;

- (id)initWithDic:(NSDictionary *)dic;


@end
