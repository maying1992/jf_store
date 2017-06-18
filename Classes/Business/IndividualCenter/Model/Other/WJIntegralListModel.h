//
//  WJIntegralListModel.h
//  jf_store
//
//  Created by maying on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJIntegralListModel : NSObject
@property(nonatomic,assign)NSInteger      totalPage;
@property(nonatomic,strong)NSMutableArray *integralList;
- (id)initWithDic:(NSDictionary *)dic;
@end
