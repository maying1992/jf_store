//
//  APITradeHallPaymentManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APITradeHallPaymentManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * feeType;
@property (nonatomic, strong) NSString * payType;

@end
