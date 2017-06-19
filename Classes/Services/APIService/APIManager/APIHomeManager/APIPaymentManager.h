//
//  APIPaymentManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIPaymentManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * payType;
@property (nonatomic, strong) NSString * orderId;

@end
