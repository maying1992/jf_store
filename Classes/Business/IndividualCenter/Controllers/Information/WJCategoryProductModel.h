//
//  WJCategoryProductModel.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCategoryProductModel : NSObject

@property(nonatomic,strong)NSString   *name;
@property(nonatomic,strong)NSString   *picUrl;
@property(nonatomic,strong)NSString   *price;
@property(nonatomic,strong)NSString   *sellingIntegral;
@property(nonatomic,strong)NSString   *shopName;
@property(nonatomic,strong)NSString   *district;
@property(nonatomic,strong)NSString   *goodsId;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
