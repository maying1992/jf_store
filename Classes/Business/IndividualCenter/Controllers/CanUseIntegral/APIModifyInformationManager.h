//
//  APIModifyInformationManager.h
//  jf_store
//
//  Created by reborn on 2017/6/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIModifyInformationManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property(nonatomic, strong)NSString *userId;
@property(nonatomic, strong)NSString *headPic;
@property(nonatomic, strong)NSString *age;
@property(nonatomic, strong)NSString *nickName;
@end
