//
//  WJOrderConfirmModel.h
//  jf_store
//
//  Created by reborn on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderConfirmModel : NSObject
@property(nonatomic,strong)NSString     *receiverName;
@property(nonatomic,strong)NSString     *phoneNumber;
@property(nonatomic,strong)NSString     *address;
@property(nonatomic,strong)NSString     *receivingId;
@property(nonatomic,strong)NSArray      *listArray;

@property(nonatomic,strong)NSString     *orderTotal;
@property(nonatomic,strong)NSString     *integralTotal;
@property(nonatomic,strong)NSString     *freightTotal;


- (id)initWithDic:(NSDictionary *)dic;

@end
