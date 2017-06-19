//
//  WeixinPayManager.h
//  HuPlus
//
//  Created by XT Xiong on 2017/3/19.
//  Copyright © 2017年 IHUJIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef enum
{
    PaymentFromTradingHallView,   //交易大厅进入判断
} PaymentFrom;

@interface WeixinPayManager : NSObject<WXApiDelegate>

+ (instancetype)WXPayManager;

@property (nonatomic, strong) WJViewController  * selectPaymentVC;
@property (nonatomic, strong) NSString          * totleCash;
@property (nonatomic, assign) PaymentFrom       * paymentFrom;


- (void)callWexinPayWithPrePayid:(NSString *)prePayid NowController:(WJViewController *)controller TotleCash:(NSString *)totleCash;

@end
