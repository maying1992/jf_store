//
//  WJAddressModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAddressModel : NSObject

@property (nonatomic, strong)NSString   *siteId;
@property (nonatomic, strong)NSString   *siteName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
