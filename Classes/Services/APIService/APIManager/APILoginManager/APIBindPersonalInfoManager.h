//
//  APIBindPersonalInfoManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIBindPersonalInfoManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * certCode;
@property (nonatomic, strong) NSString * front;
@property (nonatomic, strong) NSString * rear;




@end
