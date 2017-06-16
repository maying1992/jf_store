//
//  WJPaymentModel.h
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJPaymentModel : NSObject

@property(nonatomic,strong)NSString  *orderId;
@property(nonatomic,strong)NSString  *orderName;
@property(nonatomic,strong)NSString  *orderTotal;
@property(nonatomic,strong)NSString  *payMentType; // 失效的支付方式 1：支付宝、2：微信、3：卡号

- (id)initWithDic:(NSDictionary *)dic;
@end
