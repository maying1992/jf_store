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


@property(nonatomic,assign)NSInteger waitPayOrderCount;
@property(nonatomic,assign)NSInteger waitDeliverOrderCount;
@property(nonatomic,assign)NSInteger waitReceiveOrderCount;
@property(nonatomic,assign)NSInteger finishOrderCount;
@property(nonatomic,assign)NSInteger refundOrderCount;

@property(nonatomic,strong)NSString  *storeId;
@property(nonatomic,strong)NSString  *userType; //用户类型 1.未激活用户 2.激活用户 3.报单中心（用户服务中心） 4.分公司


@property(nonatomic,assign)NSInteger messageCount;        //消息

- (id)initWithDic:(NSDictionary *)dic;


@end
