//
//  WJLoginController.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"

typedef enum
{
    LoginFromTradingHallView,      //交易大厅进入判断
    LoginFromTabIndividualCenter, //tab个人中心
    LoginFromWebToUserId,        //给H5 userid
} LoginFrom;

@interface WJLoginController : WJViewController

@property(nonatomic , assign)LoginFrom      loginFrom;

@end
