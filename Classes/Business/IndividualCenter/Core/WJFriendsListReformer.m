//
//  WJFriendsListReformer.m
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJFriendsListReformer.h"
#import "WJFriendListModel.h"
@implementation WJFriendsListReformer
- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    WJFriendListModel *friendListModel = [[WJFriendListModel alloc] initWithDic:data];
    
    return friendListModel;
}
@end
