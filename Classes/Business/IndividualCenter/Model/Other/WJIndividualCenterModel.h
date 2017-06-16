//
//  WJIndividualCenterModel.h
//  jf_store
//
//  Created by reborn on 17/5/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJIndividualCenterModel : NSObject
@property(nonatomic,assign)NSInteger creditsCount;
@property(nonatomic,assign)NSInteger friendsCount;

@property(nonatomic,assign)NSInteger shopOrderCount;      //购物订单数量
@property(nonatomic,assign)NSInteger rechargeOrderCount;  //充值订单数量
@property(nonatomic,assign)NSInteger givingOrderCount;    //赠送订单数量
@property(nonatomic,assign)NSInteger creditsSwitchCount;  //积分互转数量
@property(nonatomic,assign)NSInteger dealOrderCount;      //交易大厅数量

@property(nonatomic,assign)NSInteger messageCount;        //消息

- (id)initWithDic:(NSDictionary *)dic;


@end
