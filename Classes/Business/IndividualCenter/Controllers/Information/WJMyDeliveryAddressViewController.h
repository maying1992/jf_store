//
//  WJMyDeliveryAddressViewController.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"
#import "WJDeliveryAddressModel.h"

typedef NS_ENUM(NSInteger, AddressFromVC){
    
    fromIndividualVC = 0,        // 个人中心
    fromOrderConfirmVC = 1,      // 确认订单
};

typedef void(^SelectAddressBlock)(WJDeliveryAddressModel *addressModel);

@interface WJMyDeliveryAddressViewController : WJViewController

@property(nonatomic,strong)SelectAddressBlock selectAddressBlock;
@property(nonatomic,assign)AddressFromVC      addressFromVC;
@end
