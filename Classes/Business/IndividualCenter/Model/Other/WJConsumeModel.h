//
//  WJConsumeModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJConsumeModel : NSObject

@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *integral;
@property(nonatomic,strong)NSString *integralId;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end
