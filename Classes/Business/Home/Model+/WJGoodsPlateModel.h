//
//  WJGoodsPlateModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsPlateModel : NSObject

@property (nonatomic, strong) NSString   * categroyId;
@property (nonatomic, strong) NSString   * categroyName;
@property (nonatomic, strong) NSString   * picUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
