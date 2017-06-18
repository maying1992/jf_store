//
//  WJTradingHallRechargeViewController.h
//  jf_store
//
//  Created by XT Xiong on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"

typedef enum
{
    TradingHallRechargeFromTradingHallView,      //交易大厅进入判断

} TradingHallRechargeFrom;

@interface WJTradingHallRechargeViewController : WJViewController

@property (nonatomic , strong) NSMutableArray               * dataArray;
@property (nonatomic , assign) TradingHallRechargeFrom        rechargeFrom;

@end
