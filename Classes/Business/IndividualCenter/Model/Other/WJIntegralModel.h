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
@property(nonatomic,strong)NSString     *consumptionType; //收支类型 1.收入积分 2 支出积分
@property(nonatomic,strong)NSString     *returnTime;
@property(nonatomic,strong)NSString     *tradeTime; //交易时间
@property(nonatomic,strong)NSString     *total;

- (id)initWithDic:(NSDictionary *)dic;


@end
