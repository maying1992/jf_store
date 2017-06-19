//
//  WJProductModel.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJProductModel : NSObject
@property(nonatomic,strong)NSString        *productId;
@property(nonatomic,strong)NSString        *name;
@property(nonatomic,strong)NSString        *imageUrl;
@property(nonatomic,assign)NSInteger       count;
@property(nonatomic,strong)NSString        *standardDes;  //规格
@property(nonatomic,strong)NSString        *logisticsIntegral;
@property(nonatomic,strong)NSString        *orderIntegral;
@property(nonatomic,strong)NSString        *orderTotal;


@property(nonatomic,assign)NSInteger       stock;

@property(nonatomic,assign)ProductStatus   productStatus;   //商品退款状态
@property(nonatomic,strong)NSString        *refundPrice;    //退款金额
@property(nonatomic,strong)NSString        *logisticsCost;  //物流费用(仅退款状态)
@property(nonatomic,strong)NSString        *shopId;
@property(nonatomic,strong)NSString        *skuId;
@property(nonatomic,strong)NSString        *cartId;
@property(nonatomic,strong)NSString        *brandId;
@property(nonatomic,strong)NSString        *brandName;
@property(nonatomic,strong)NSMutableArray  *attributeArray;
@property(nonatomic,assign)BOOL            isSelect;


- (id)initWithDic:(NSDictionary *)dic;
@end
