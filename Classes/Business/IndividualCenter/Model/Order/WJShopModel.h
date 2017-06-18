//
//  WJShopModel.h
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJShopModel : NSObject

@property(nonatomic,strong) NSString        *shopName;
@property(nonatomic,strong) NSString        *shopId;
@property(nonatomic,assign) OrderStatus     orderStatus;


@property(nonatomic,strong) NSString        *payPrice;
@property(nonatomic,strong) NSString        *payIntegral;

@property(nonatomic,strong) NSString        *freight;
@property(nonatomic,strong) NSString        *freightIntegral;


@property(nonatomic,strong)NSMutableArray   *productList;

- (id)initWithDic:(NSDictionary *)dic;


@end
