//
//  APISetIntegralPasswordManager.h
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APISetIntegralPasswordManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>


@property (nonatomic, strong) NSString *password;

@end
