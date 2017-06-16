//
//  WJIndividualOrderListModel.h
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJIndividualOrderListModel : NSObject
@property(nonatomic,assign)NSInteger      totalPage;
@property(nonatomic,strong)NSMutableArray *orderList;
- (id)initWithDic:(NSDictionary *)dic;
@end
