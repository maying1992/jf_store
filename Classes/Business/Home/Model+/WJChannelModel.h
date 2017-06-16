//
//  WJChannelModel.h
//  jf_store
//
//  Created by XT Xiong on 2017/6/13.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJChannelModel : NSObject

@property (nonatomic, strong) NSString   * channelId;
@property (nonatomic, strong) NSString   * channelName;
@property (nonatomic, strong) NSString   * channelPic;
//@property (nonatomic, strong) NSString   * channelType;
@property (nonatomic, strong) NSString   * relationType;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
