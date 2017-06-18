//
//  WJAtrrValueModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAtrrValueModel : NSObject

@property (nonatomic, strong) NSString          * attrName;
@property (nonatomic, strong) NSString          * imgUrl;
@property (nonatomic, strong) NSMutableArray    * valueId;
@property (nonatomic, strong) NSMutableArray    * valueName;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
