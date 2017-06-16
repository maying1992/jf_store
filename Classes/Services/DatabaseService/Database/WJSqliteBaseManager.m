//
//  WJSqliteBaseManager.m
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//
#import "WJSqliteBaseManager.h"

#define DATABASE_BASEDBNAME               @"City.db"

static WJSqliteBaseManager *sharedInstance = nil;

@implementation WJSqliteBaseManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WJSqliteBaseManager alloc] initWithDBPath:DATABASE_BASEDBNAME];
    });
    
    return sharedInstance;
}

+ (void)copyBaseData{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *soruceDBPath = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"db"];
    
    if (soruceDBPath) {
        NSString *destDBPath = [NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), DATABASE_FOLDER, DATABASE_BASEDBNAME];
        
        NSError *error = nil;
        if([WJUtilityMethod createDirectoryIfNotPresent:DATABASE_FOLDER] && [fm fileExistsAtPath:destDBPath]){//如果已经存在，则删除已经存在的
            [fm removeItemAtPath:destDBPath error:&error];
        }
        BOOL result = [fm copyItemAtPath:soruceDBPath toPath:destDBPath error:&error];
        if(result){//拷贝，已经生成的数据库
            NSLog(@"copy success");
        }
        else{
            if(error){
                NSLog(@"error = %@",error);
            }
        }
        
    }else{
        [[WJSqliteBaseManager sharedManager] upgradeTables];
    }
}

- (void)upgradeTables
{
    if ([self.db open]) {
        
        NSString* sqlStr;
        
        if (![self.db tableExists:@"gen_area"]) {
            sqlStr = @"CREATE TABLE [gen_area] (\
            [AREA_ID] INTEGER NOT NULL,\
            [AREA_NO] TEXT NOT NULL,\
            [AREA_NAME] TEXT NOT NULL,\
            [AREA_PARENTNO] TEXT DEFAULT NULL,\
            [AREA_RANK] INTEGER NOT NULL\
            )";
            
            [self.db executeUpdate:sqlStr];
        }
    }
}


@end
