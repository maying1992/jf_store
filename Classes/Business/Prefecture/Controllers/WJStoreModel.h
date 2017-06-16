//
//  WJStoreModel.h
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJStoreModel : NSObject

@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *storeNotice;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *region;
@property(nonatomic,strong)NSString *address;

- (id)initWithDic:(NSDictionary *)dic;
@end
