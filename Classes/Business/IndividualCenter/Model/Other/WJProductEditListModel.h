//
//  WJProductEditListModel.h
//  jf_store
//
//  Created by reborn on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJProductEditListModel : NSObject

@property(nonatomic,strong)NSString *productName;
@property(nonatomic,strong)NSString *productDes;
@property(nonatomic,strong)NSMutableArray *listArray;

- (id)initWithDic:(NSDictionary *)dic;
@end
