//
//  APIBondRecyleManager.h
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIBondRecyleManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>


@property(nonatomic,strong)NSString *bond;

@end
