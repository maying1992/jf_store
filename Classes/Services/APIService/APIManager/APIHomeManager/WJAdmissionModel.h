//
//  WJAdmissionModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAdmissionModel : NSObject

@property (nonatomic, strong)NSString   *admissionMoney;
@property (nonatomic, strong)NSString   *admissionType;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
