//
//  WJPrizeResultListModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJPrizeResultListModel : NSObject

@property (nonatomic, strong) NSString   * prizeNum;
@property (nonatomic, strong) NSString   * userName;
@property (nonatomic, strong) NSString   * goodsName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
