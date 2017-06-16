//
//  APIRecommenderInfoManager.h
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIRecommenderInfoManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString *recommenderCode;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *verifiationCode;

@end
