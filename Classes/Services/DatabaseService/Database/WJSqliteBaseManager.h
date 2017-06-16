//
//  WJSqliteBaseManager.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "SqliteManager.h"

@interface WJSqliteBaseManager : SqliteManager

+ (instancetype)sharedManager;

+ (void)copyBaseData;

@end
