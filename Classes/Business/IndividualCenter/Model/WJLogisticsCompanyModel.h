//
//  WJLogisticsCompanyModel.h
//  jf_store
//
//  Created by reborn on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJLogisticsCompanyModel : NSObject
@property(nonatomic,strong)NSString       *logisticsCompanyId;
@property(nonatomic,strong)NSString       *logisticsCompanyName;

- (id)initWithDic:(NSDictionary *)dic;
@end
