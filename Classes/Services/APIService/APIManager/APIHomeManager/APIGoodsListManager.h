//
//  APIGoodsListManager.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIGoodsListManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * categoryID;
@property (nonatomic, strong) NSString * brandID;
@property (nonatomic, strong) NSString * brandName;
@property (nonatomic, strong) NSString * condition;
@property (nonatomic, strong) NSString * orderField;
@property (nonatomic, strong) NSString * orderType;
@property (nonatomic, assign) NSInteger  pageCount;                  //  每页的个数   默认10
@property (nonatomic, assign) NSInteger  firstPageNo;                //  第一页页数   默认1

@end
