//
//  WJDeliveryAddressListModel.h
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJDeliveryAddressListModel : NSObject
@property(nonatomic,strong)NSMutableArray *addresslistArray;
@property(nonatomic,assign)NSInteger      totalPage;

- (id)initWithDic:(NSDictionary *)dic;
@end
