//
//  WJCategoryListModel.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCategoryListModel : NSObject

@property(nonatomic,strong)NSString         *categoryId;
@property(nonatomic,strong)NSString         *categoryName;

@property(nonatomic,assign)BOOL             isSelect;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
