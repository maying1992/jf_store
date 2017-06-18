//
//  WJServiceCenterConditionModel.h
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJServiceCenterConditionModel : NSObject
@property(nonatomic,strong)NSString *amount; //金额
@property(nonatomic,strong)NSString *freezeIntegral; //待用积分
@property(nonatomic,strong)NSString *integralStandard; //待用积分标准
@property(nonatomic,strong)NSString *member; //直推会员
@property(nonatomic,strong)NSString *memberStandard; //直推会员标准
@property(nonatomic,strong)NSString *memberIntegralStandard; //直推会员积分标准


- (instancetype)initWithDic:(NSDictionary *)dic;
@end
