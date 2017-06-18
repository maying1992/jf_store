//
//  APIBindingServiceCenterManager.h
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIBindingServiceCenterManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property(nonatomic,strong)NSString *centerId;
@property(nonatomic,strong)NSString *operation; //1.绑定 2.解绑
//@property(nonatomic,strong)NSString *userID;
@end
