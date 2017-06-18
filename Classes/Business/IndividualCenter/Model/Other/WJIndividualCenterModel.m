//
//  WJIndividualCenterModel.m
//  jf_store
//
//  Created by reborn on 17/5/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualCenterModel.h"

@implementation WJIndividualCenterModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.creditsCount = [dic[@"integral"] integerValue];
        self.friendsCount = [dic[@"friends_num"] integerValue];

        self.waitPayOrderCount = [dic[@"pending_payment"] integerValue];
        self.waitDeliverOrderCount = [dic[@"deliver_goods"] integerValue];
        self.waitReceiveOrderCount = [dic[@"take_delivery"] integerValue];
        self.finishOrderCount = [dic[@"deliver_goods"] integerValue];
        self.refundOrderCount = [dic[@"refund_num"] integerValue];


        self.storeId = dic[@"store_id"];
        self.userType = [dic[@"user_type"] integerValue];
        self.messageCount = [dic[@"news_num"] integerValue];
    }
    
    return self;
}
@end
