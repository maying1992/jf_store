//
//  WJServiceCenterActivateModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJServiceCenterActivateModel : NSObject

@property(nonatomic,strong)NSString *submitTime;
@property(nonatomic,strong)NSString *userCode;
@property(nonatomic,strong)NSString *integral;
@property(nonatomic,strong)NSString *integralId;
@property(nonatomic,assign)BOOL     isSelect;

- (id)initWithDic:(NSDictionary *)dic;
@end
