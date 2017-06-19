//
//  WJOrderIntegralListModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderIntegralListModel : NSObject

@property(nonatomic,strong) NSString             * integralMultiple;
@property(nonatomic,strong) NSString             * integralType;

- (id)initWithDic:(NSDictionary *)dic;

@end
