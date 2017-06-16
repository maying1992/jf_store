//
//  WJMyDeliveryAddressReformer.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMyDeliveryAddressReformer.h"
#import "WJDeliveryAddressListModel.h"
@implementation WJMyDeliveryAddressReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJDeliveryAddressListModel *addressListModel = [[WJDeliveryAddressListModel alloc] initWithDic:data[@"val"]];
    
    return addressListModel;
}
@end
