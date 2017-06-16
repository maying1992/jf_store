//
//  APIApplyRefundManager.h
//  jf_store
//
//  Created by reborn on 2017/5/25.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIApplyRefundManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *refundReason;
@property (nonatomic, strong) NSString *refundDescribe;


@end
