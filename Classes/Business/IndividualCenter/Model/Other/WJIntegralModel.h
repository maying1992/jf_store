//
//  WJIntegralModel.h
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJIntegralModel : NSObject
@property(nonatomic,strong)NSString     *remark;
@property(nonatomic,strong)NSString     *integralNo;
@property(nonatomic,strong)NSString     *tradeType;
@property(nonatomic,strong)NSString     *consumptionType;
@property(nonatomic,strong)NSString     *time;
@property(nonatomic,strong)NSString     *tradeTime;
@property(nonatomic,strong)NSString     *total;

- (id)initWithDic:(NSDictionary *)dic;


@end
