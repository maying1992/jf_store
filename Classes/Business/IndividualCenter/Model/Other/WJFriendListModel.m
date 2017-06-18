//
//  WJFriendListModel.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJFriendListModel.h"
#import "WJMemberModel.h"
@implementation WJFriendListModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.totalPage = [dic[@"total_page"] integerValue];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *orderDic in dic[@"user_list"]) {
            WJMemberModel *memberModel = [[WJMemberModel alloc] initWithDic:orderDic];
            [arr addObject:memberModel];
        }
        self.friendsList = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
