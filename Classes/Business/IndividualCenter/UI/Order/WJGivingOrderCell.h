//
//  WJGivingOrderCell.h
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderModel.h"

@interface WJGivingOrderCell : UITableViewCell
@property(nonatomic, strong)WJActionBlock cancelCheckBlock;
@property(nonatomic, strong)WJActionBlock deleteOrderBlock;

-(void)configDataWithOrder:(WJOrderModel *)order;
@end
