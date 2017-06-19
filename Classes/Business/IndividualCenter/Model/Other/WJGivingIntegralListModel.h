//
//  WJGivingIntegralListModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGivingIntegralListModel : NSObject
@property(nonatomic,assign)NSInteger      totalPage;
@property(nonatomic,strong)NSMutableArray *list;
- (id)initWithDic:(NSDictionary *)dic;
@end
