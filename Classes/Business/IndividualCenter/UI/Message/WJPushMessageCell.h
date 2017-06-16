//
//  WJPushMessageCell.h
//  jf_store
//
//  Created by WJSystemMessageCell on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSystemMessageModel.h"

@interface WJPushMessageCell : UITableViewCell

- (void)configData:(WJSystemMessageModel *)model;

@end
