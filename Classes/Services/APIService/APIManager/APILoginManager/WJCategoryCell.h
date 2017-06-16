//
//  WJCategoryCell.h
//  jf_store
//
//  Created by reborn on 17/5/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCategoryListModel.h"
@interface WJCategoryCell : UITableViewCell

-(void)configDataWithCategoryListModel:(WJCategoryListModel *)model;

@end
