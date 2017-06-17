//
//  WJGoodsDetailModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsDetailModel : NSObject

@property (nonatomic, strong) NSString          * prizeId;
@property (nonatomic, strong) NSString          * goodsId;
@property (nonatomic, strong) NSString          * goodsName;
@property (nonatomic, strong) NSString          * picUrl;
@property (nonatomic, strong) NSString          * integral;
@property (nonatomic, strong) NSString          * prizeTimes;
@property (nonatomic, strong) NSString          * prizeCount;
@property (nonatomic, strong) NSMutableArray    * picInfoList;
@property (nonatomic, strong) NSString          * linkUrl;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
