//
//  WJAllTypeIntegralModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAllTypeIntegralModel : NSObject
@property(nonatomic,strong)NSString *canUseIntegral;
@property(nonatomic,strong)NSString *shopIntegral;
@property(nonatomic,strong)NSString *shareIntegral;
@property(nonatomic,strong)NSString *waitUseIntegral;
@property(nonatomic,strong)NSString *multifunctionalIntegral;
@property(nonatomic,strong)NSString *redIntegral;
@property(nonatomic,strong)NSString *doubleTotalIntegral;
@property(nonatomic,assign)NSInteger operationStatus; //1.未绑定 2.激活 3.复投

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
