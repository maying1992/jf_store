//
//  WJGoodsModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsModel : NSObject

@property (nonatomic, strong) NSString   * brandName;
@property (nonatomic, strong) NSString   * goodsId;
@property (nonatomic, strong) NSString   * goodsName;
@property (nonatomic, strong) NSString   * picUrl;
@property (nonatomic, strong) NSString   * sellingIntegral;
@property (nonatomic, strong) NSString   * sellingPrice;




- (instancetype)initWithDic:(NSDictionary *)dic;

@end
