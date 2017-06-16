//
//  WJLogisticsCell.h
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJLogisticsCell : UITableViewCell

+ (float)cellHeightWithString:(NSString *)str isContentHeight:(BOOL)b;

- (void)setDataSource:(NSString *)content isFirst:(BOOL)isFirst isLast:(BOOL)isLast;
@end
