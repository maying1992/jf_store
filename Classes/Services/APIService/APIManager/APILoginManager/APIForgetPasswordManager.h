//
//  APIForgetPasswordManager.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIForgetPasswordManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *verifyCode;


@end
