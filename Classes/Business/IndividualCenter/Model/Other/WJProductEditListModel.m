//
//  WJProductEditListModel.m
//  jf_store
//
//  Created by reborn on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJProductEditListModel.h"
#import "WJProductEditModel.h"
@implementation WJProductEditListModel
- (id)initWithDic:(NSDictionary *)dic
{
    self.productName = ToString(dic[@"name"]);
    self.productDes = ToString(dic[@"des"]);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *productDic in dic[@"list"]) {
        WJProductEditModel *productEditModel = [[WJProductEditModel alloc] initWithDic:productDic];
        [arr addObject:productEditModel];
    }
    self.listArray = [NSMutableArray arrayWithArray:arr];
    [arr removeAllObjects];
    
    return self;
}
@end
