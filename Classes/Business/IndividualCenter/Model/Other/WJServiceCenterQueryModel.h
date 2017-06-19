//
//  WJServiceCenterQueryModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJServiceCenterQueryModel : NSObject

@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *redIntegral;
@property(nonatomic,strong)NSString *effective;

@property(nonatomic,assign)NSInteger      totalPage;
@property(nonatomic,strong)NSMutableArray *integralList;
- (id)initWithDic:(NSDictionary *)dic;

@end
