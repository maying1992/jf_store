//
//  WJOrderDetailModel.h
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderDetailModel : NSObject
@property(nonatomic,strong) NSString        *orderNo;
@property(nonatomic,strong) NSString        *receiveName;
@property(nonatomic,strong) NSString        *address;
@property(nonatomic,strong) NSString        *phone;

@property(nonatomic,strong) NSString        *submitTime;
@property(nonatomic,strong) NSString        *payTime;

@property(nonatomic,strong) NSString        *orderPrice;
@property(nonatomic,strong) NSString        *orderIntegral;

@property (nonatomic ,assign) OrderStatus    orderStatus;
@property(nonatomic,strong)NSMutableArray   *shopList;


- (id)initWithDic:(NSDictionary *)dic;

@end
