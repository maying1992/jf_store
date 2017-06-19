//
//  WJOnlinePayModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOnlinePayModel : NSObject

@property(nonatomic,strong) NSString        *accountBalance;
@property(nonatomic,strong) NSString        *orderId;
@property(nonatomic,strong) NSString        *orderIntegral;
@property(nonatomic,strong) NSString        *orderName;
@property(nonatomic,strong) NSString        *orderTotal;
@property(nonatomic,strong) NSString        *payType;


- (id)initWithDic:(NSDictionary *)dic;

@end
