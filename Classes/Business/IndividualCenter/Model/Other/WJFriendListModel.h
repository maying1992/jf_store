//
//  WJFriendListModel.h
//  jf_store
//
//  Created by maying on 2017/6/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJFriendListModel : NSObject
@property(nonatomic,assign)NSInteger      totalPage;
@property(nonatomic,strong)NSMutableArray *friendsList;
- (id)initWithDic:(NSDictionary *)dic;

@end
