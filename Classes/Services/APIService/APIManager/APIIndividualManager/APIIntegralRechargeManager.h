//
//  APIIntegralRechargeManager.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIIntegralRechargeManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property(nonatomic,strong)NSString *integralType; //1.可用积分 2.红积分 3.分享积分
@property(nonatomic,strong)NSString *payType; //1.支付宝 2.微信
@property(nonatomic,strong)NSString *rechargeAmount;

@end
