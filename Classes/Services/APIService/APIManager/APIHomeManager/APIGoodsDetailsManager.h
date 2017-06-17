//
//  APIGoodsDetailsManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIGoodsDetailsManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, assign) NSString      * goodsId;

@end
