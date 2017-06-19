//
//  WJGivingListTCell.h
//  jf_store
//
//  Created by reborn on 2017/5/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGivingIntegralModel.h"
@interface WJGivingListTCell : UITableViewCell
@property(nonatomic,strong)WJActionBlock tapGivingBlock;
-(void)configDataWithModel:(WJGivingIntegralModel *)model;
@end
