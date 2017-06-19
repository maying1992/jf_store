//
//  APICancelOrderManager.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APICancelOrderManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *cancelReason;
@end
