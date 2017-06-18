//
//  WJMemberModel.h
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJMemberModel : NSObject
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *headPic;
@property (nonatomic , strong) NSString *userCode;
@property (nonatomic , assign) NSInteger remuneration;
@property (nonatomic , assign) NSInteger friendsCount;

@property (nonatomic , assign) NSInteger number;

@property (nonatomic , assign) BOOL      isSelect;
- (id)initWithDic:(NSDictionary *)dic;

@end
