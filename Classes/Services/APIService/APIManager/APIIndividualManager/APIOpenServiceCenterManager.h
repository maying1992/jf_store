//
//  APIOpenServiceCenterManager.h
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIOpenServiceCenterManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property(nonatomic,strong)NSString *payAmount;
@property(nonatomic,strong)NSString *payType;  //1.支付宝 2.微信

@end
