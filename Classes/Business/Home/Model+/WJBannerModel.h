//
//  WJBannerModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/13.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJBannerModel : NSObject

@property (nonatomic, strong) NSString   * descriptions;
@property (nonatomic, strong) NSString   * linkType;
@property (nonatomic, strong) NSString   * linkUrl;
@property (nonatomic, strong) NSString   * picUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
