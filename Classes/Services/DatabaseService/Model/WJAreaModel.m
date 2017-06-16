//
//  WJAreaModel.m
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAreaModel.h"
#import "WJDBTableKeys.h"

@implementation WJAreaModel

-(id)init{
    if (self = [super init]) {
        self.areaId = 0;
        self.areaNo=@"";
        self.areaName=@"";
        self.areaParentNo=@"";
        self.areaRank=0;
    }
    return self;
}

-(id)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        self.areaId =       [[dic objectForKey:COL_AREA_ID] integerValue];
        self.areaNo =       [dic objectForKey:COL_AREA_NO]?:@"";
        self.areaName =     [dic objectForKey:COL_AREA_NAME]?:@"";
        self.areaParentNo = ToString([dic objectForKey:COL_AREA_PARENTNO]);
        self.areaRank =     [[dic objectForKey:COL_AREA_RANK] integerValue];
    }
    return self;
}

-(id)initWithCursor:(FMResultSet *)cursor{
    if (self = [super init]) {
        self.areaId =       [cursor intForColumn:COL_AREA_ID];
        self.areaNo =       [cursor stringForColumn:COL_AREA_NO];
        self.areaName =     [cursor stringForColumn:COL_AREA_NAME];
        self.areaParentNo = [cursor stringForColumn:COL_AREA_PARENTNO];
        self.areaRank =     [cursor intForColumn:COL_AREA_RANK];
    }
    return self;
}

@end
