//
//  WJGoodsDetailModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsDetailModel : NSObject

@property (nonatomic, strong) NSString          * goodsBrief;
@property (nonatomic, strong) NSString          * goodsId;
@property (nonatomic, strong) NSString          * goodsName;
@property (nonatomic, strong) NSString          * linkUrl;
@property (nonatomic, strong) NSString          * address;
@property (nonatomic, strong) NSString          * sellingIntegral;
@property (nonatomic, strong) NSString          * sellingPrice;
@property (nonatomic, strong) NSMutableArray    * logisticsCost;
@property (nonatomic, strong) NSString          * logisticsIntegral;
@property (nonatomic, strong) NSString          * salesCount;
@property (nonatomic, strong) NSString          * storeId;
@property (nonatomic, strong) NSMutableArray    * picList;
@property (nonatomic, strong) NSMutableArray    * attributeList;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
