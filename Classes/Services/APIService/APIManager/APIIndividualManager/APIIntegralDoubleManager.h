//
//  APIIntegralDoubleManager.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIIntegralDoubleManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>
@property(nonatomic,strong)NSString *integral;
@property(nonatomic,strong)NSString *integralId;

@end
