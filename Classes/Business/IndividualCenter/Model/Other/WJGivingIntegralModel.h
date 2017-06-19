//
//  WJGivingIntegralModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGivingIntegralModel : NSObject
@property(nonatomic,strong)NSString *integralId;
@property(nonatomic,strong)NSString *integral;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *remark;

@property(nonatomic,assign)NSInteger isDoubly; //1.可赠送 2.不可赠送

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
