//
//  WJEditAddressViewController.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"
#import "WJDeliveryAddressModel.h"

typedef NS_ENUM(NSInteger, AddressViewType){
    
    AddressViewTypeNew = 0,         // 设置收货地址
    AddressViewTypeEdit = 1,       //  编辑修改地址
};

@interface WJEditAddressViewController : WJViewController
@property(nonatomic,strong)WJDeliveryAddressModel *deliveryAddressModel;
@property(nonatomic,assign)AddressViewType        addressViewType;
@end
