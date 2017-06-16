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
        
        self.creditsCount = [dic[@"usePoint"] integerValue];
        self.friendsCount = [dic[@"friendNum"] integerValue];

        self.shopOrderCount = [dic[@"shopOrderNum"] integerValue];
        self.rechargeOrderCount = [dic[@"rechargeOrderNum"] integerValue];
        self.givingOrderCount = [dic[@"givingOrderNum"] integerValue];
        self.creditsSwitchCount = [dic[@"pointSwitchNum"] integerValue];
        self.dealOrderCount = [dic[@"dealOrderNum"] integerValue];
        self.messageCount = [dic[@"messageNum"] integerValue];
    }
    
    return self;
}
@end
