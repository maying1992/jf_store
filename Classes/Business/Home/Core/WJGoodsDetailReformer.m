//
//  WJGoodsDetailReformer.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsDetailReformer.h"
#import "WJGoodsDetailModel.h"
#import "WJAtrrValueModel.h"

@implementation WJGoodsDetailReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    WJGoodsDetailModel * categoryModel = [[WJGoodsDetailModel alloc] initWithDic:data];
    
    NSMutableArray  * sizeArray = [NSMutableArray array];
    NSMutableArray  * colorArray = [NSMutableArray array];
    for (NSDictionary * dic in data[@"attribute_list"]) {
        if ([dic[@"attr_name"]isEqualToString:@"尺码"]) {
            for (NSDictionary * siseDic in dic[@"atrr_vlaue_list"]) {
                WJAtrrValueModel * categoryModel = [[WJAtrrValueModel alloc] initWithDic:siseDic];
                [sizeArray addObject:categoryModel];
            }
        }
        if ([dic[@"attr_name"]isEqualToString:@"颜色"]) {
            for (NSDictionary * colorDic in dic[@"atrr_vlaue_list"]) {
                WJAtrrValueModel * categoryModel = [[WJAtrrValueModel alloc] initWithDic:colorDic];
                [colorArray addObject:categoryModel];
            }
        }
    }
    
    [dataDic setValue:categoryModel forKey:@"categoryModel"];
    [dataDic setValue:sizeArray forKey:@"size_list"];
    [dataDic setValue:colorArray forKey:@"color_list"];
    
    return dataDic;
}

@end
