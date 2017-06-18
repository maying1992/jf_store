//
//  APIPayNowManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIPayNowManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * attrRelationids;
@property (nonatomic, strong) NSString * storeId;
@property (nonatomic, strong) NSString * goodsNum;
@property (nonatomic, strong) NSString * goodsID;


@end
