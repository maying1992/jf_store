//
//  WJDBAreaManager.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "BaseDBManager.h"
#import "BaseDBManager.h"
#import "WJAreaModel.h"

@interface WJDBAreaManager : BaseDBManager

-(NSMutableArray *)getSubAreaByParentId:(NSString *)parentId;

-(NSMutableArray *)getAllAreasByLevel:(NSInteger)level;//省1 城市2


@end
