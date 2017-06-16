//
//  WJOrderConfirmController.h
//  jf_store
//
//  Created by reborn on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"

typedef NS_ENUM(NSInteger,OrderConfirmFromController){
    
    FromPayRightNow = 0,    //立即购买
    FromShopCart = 1,       //购物车
};


@interface WJOrderConfirmController : WJViewController
@property(nonatomic,assign)OrderConfirmFromController    orderConfirmFromController;

@end
