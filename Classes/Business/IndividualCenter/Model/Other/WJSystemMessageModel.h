//
//  WJSystemMessageModel.h
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJSystemMessageModel : NSObject
@property(nonatomic,strong)NSString     *messageId;
@property(nonatomic,strong)NSString     *title;
@property(nonatomic,strong)NSString     *content;
@property(nonatomic,strong)NSString     *date;
@property(nonatomic,strong)NSString     *time;
@property(nonatomic,strong)NSString     *orderNo;
@property(nonatomic,strong)NSString     *imgUrl;
@property(nonatomic,assign)NSInteger    messageType; //1.推送消息 2.激活申请 3.续费提醒 4.赠送申请 5.绑定申请 6、解除绑定


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
