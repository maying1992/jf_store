//
//  APIDealAddressManager.h
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIDealAddressManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property (nonatomic, strong) NSString *receiveId;
@property (nonatomic, strong) NSString *receiveName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *districtId;

@property (nonatomic, assign) NSInteger isDefault;
@property (nonatomic, assign) NSInteger status; //操作类型 1.新增/修改 2.删除

@end
