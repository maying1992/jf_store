//
//  WJHomeReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/13.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJHomeReformer.h"
#import "WJGoodsModel.h"
#import "WJBannerModel.h"
#import "WJChannelModel.h"

@implementation WJHomeReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray  * goodsListArray = [NSMutableArray array];
    for (NSDictionary * dic in data[@"goods_list"]) {
        WJGoodsModel *categoryModel = [[WJGoodsModel alloc] initWithDic:dic];
        [goodsListArray addObject:categoryModel];
    }
    NSMutableArray  * channelListArray = [NSMutableArray array];
    for (NSDictionary * dic in data[@"channel_list"]) {
        WJChannelModel *categoryModel = [[WJChannelModel alloc] initWithDic:dic];
        [channelListArray addObject:categoryModel];
    }
    NSMutableArray  * picListArray = [NSMutableArray array];
    for (NSDictionary * dic in data[@"pic_list"]) {
        WJBannerModel *categoryModel = [[WJBannerModel alloc] initWithDic:dic];
        [picListArray addObject:categoryModel];
    }
    
    [dic setValue:goodsListArray forKey:@"goods_list"];
    [dic setValue:channelListArray forKey:@"channel_list"];
    [dic setValue:picListArray forKey:@"pic_list"];
    
    return dic;
}

@end
