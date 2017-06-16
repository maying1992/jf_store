//
//  WJLogisticsModel.h
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJLogisticsModel : NSObject
@property(nonatomic,strong)NSString       *orderNo;
@property(nonatomic,strong)NSString       *logisticsName;
@property(nonatomic,strong)NSString       *logisticsPhone;
@property(nonatomic,strong)NSMutableArray *listArray;

- (id)initWithDic:(NSDictionary *)dic;

@end
