//
//  APIVerifyCodeManager.h
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIVerifyCodeManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString *loginName;
@end
