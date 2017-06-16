//
//  BaseDBModel.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface BaseDBModel : NSObject

-(id)initWithDic:(NSDictionary*)dic;

- (id)initWithCursor:(FMResultSet *)cursor;
@end
