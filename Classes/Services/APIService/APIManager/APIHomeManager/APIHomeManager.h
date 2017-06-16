//
//  APIHomeManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIHomeManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, assign) NSInteger  pageCount;                  //  每页的个数   默认10
@property (nonatomic, assign) NSInteger  firstPageNo;                //  第一页页数   默认1

@end
