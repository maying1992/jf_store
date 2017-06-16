//
//  BaseDBManager.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJDBTableKeys.h"
#import "FMDB.h"

@class SqliteManager;

@interface BaseDBManager : NSObject

@property (nonatomic, strong) SqliteManager *sqliteManager;

- (FMResultSet *)queryInTable:(NSString *)table
             withWhereClauses:(NSString *)whereClause
           withWhereArguments:(NSArray *)whereArgumentsInArray
                  withOrderBy:(NSString *) order
                withOrderType:(TS_ORDER_E) orderType;


- (FMResultSet *)queryAllInTable:(NSString *)table;


- (FMResultSet*)querySql:(NSString*)sql;
@end
