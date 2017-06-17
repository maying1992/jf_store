//
//  APIVerifyPayPasswordManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIVerifyPayPasswordManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * password;

@end
