//
//  WJAttributeDetailModel.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAttributeDetailModel : NSObject
@property(nonatomic,strong)NSString *attributeName;
@property(nonatomic,strong)NSString *valueName;
//@property(nonatomic,strong)NSString *valueId;
//
//
//@property(nonatomic,strong)NSString *price;
//@property(nonatomic,strong)NSString *originalPrice;
//@property(nonatomic,strong)NSString *skuId;
//@property(nonatomic,strong)NSString *stock;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
