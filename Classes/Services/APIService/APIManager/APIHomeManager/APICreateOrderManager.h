//
//  APICreateOrderManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APICreateOrderManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * receivingId;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * integralType;
@property (nonatomic, strong) NSString * skuId;
@property (nonatomic, strong) NSString * goodsNum;
@property (nonatomic, strong) NSString * cartList;
@property (nonatomic, strong) NSString * storeId;


@end
