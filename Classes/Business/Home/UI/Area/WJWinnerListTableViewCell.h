//
//  WJWinnerListTableViewCell.h
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJPrizeResultListModel.h"

@interface WJWinnerListTableViewCell : UITableViewCell

-(void)configDataWithModel:(WJPrizeResultListModel *)model;

@end
