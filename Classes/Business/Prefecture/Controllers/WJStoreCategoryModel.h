//
//  WJStoreCategoryModel.h
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJStoreCategoryModel : NSObject

@property(nonatomic,strong)NSString *categoryName;
@property(nonatomic,strong)NSString *categoryId;
@property(nonatomic,assign)BOOL     isSelect;

- (id)initWithDic:(NSDictionary *)dic;

@end
