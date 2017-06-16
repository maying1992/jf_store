//
//  WJStoreProtocolViewController.h
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"

typedef enum
{
    ApplyFromEnterpriseStore,        //企业店铺
    ApplyFromPersonalStore,          //个人店铺
    ApplyFromMerchantStore,          //商家店铺
    ApplyFromEntityStore             //实体店铺
    
} ApplyFrom;

@interface WJStoreProtocolViewController : WJViewController
@property(nonatomic,assign) ApplyFrom applyFrom;

@end
