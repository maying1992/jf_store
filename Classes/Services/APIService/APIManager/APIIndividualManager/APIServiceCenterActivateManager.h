//
//  APIServiceCenterActivateManager.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIServiceCenterActivateManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property(nonatomic,strong)NSString *integralIds;
@property(nonatomic,strong)NSString *redIntegral;
@property(nonatomic,strong)NSString *useIntegral;

@end
