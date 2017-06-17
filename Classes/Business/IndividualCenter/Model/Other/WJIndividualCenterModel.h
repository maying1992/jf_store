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

@property(nonatomic,assign)NSInteger messageCount;        //消息

- (id)initWithDic:(NSDictionary *)dic;


@end
