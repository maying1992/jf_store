//
//  APIQueryIntergralListManager.h
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIQueryIntergralListManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property (nonatomic, assign) NSInteger   pageCount;    //  每页的个数   默认10
@property (nonatomic, assign) NSInteger   firstPageNo;  //  第一页页数   默认1
@property (nonatomic, assign) NSInteger   integralType; //1.可用积分 2.待用积分 3.多功能积分 4.分享积分 5.购物积分 6.红积分 7.债券

@end
