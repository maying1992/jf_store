//
//  APILoginManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APILoginManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * loginName;
@property (nonatomic, strong) NSString * password;

@end
