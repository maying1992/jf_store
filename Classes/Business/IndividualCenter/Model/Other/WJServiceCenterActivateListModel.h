//
//  WJServiceCenterActivateListModel.h
//  jf_store
//
//  Created by maying on 2017/6/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJServiceCenterActivateListModel : NSObject

@property(nonatomic,strong)NSString       *redIntegral;
@property(nonatomic,strong)NSString       *canUseIntegral;
@property(nonatomic,strong)NSString       *radio;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,assign)NSInteger      totalPage;


- (id)initWithDic:(NSDictionary *)dic;

@end
