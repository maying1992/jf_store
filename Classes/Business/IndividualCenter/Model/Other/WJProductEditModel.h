//
//  WJProductEditModel.h
//  jf_store
//
//  Created by reborn on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJProductEditModel : NSObject

@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *integral;
@property(nonatomic,strong)NSString *stock;
@property(nonatomic,strong)NSString *freight;
@property(nonatomic,strong)NSString *standard;
@property(nonatomic,strong)NSString *limitCount;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end
