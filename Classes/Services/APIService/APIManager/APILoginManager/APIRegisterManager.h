//
//  APIRegisterManager.h
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIRegisterManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString *userCode;
@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *verifiationCode;
@property (nonatomic, strong) NSString *recommenderCode;

@end
