//
//  WJLogisticsDetailModel.h
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJLogisticsDetailModel : NSObject
@property(nonatomic,strong)NSString       *context;
@property(nonatomic,strong)NSString       *time;

- (id)initWithDic:(NSDictionary *)dic;

@end
