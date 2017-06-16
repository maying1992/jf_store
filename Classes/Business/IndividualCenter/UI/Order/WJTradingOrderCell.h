//
//  WJTradingOrderCell.h
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderModel.h"

@interface WJTradingOrderCell : UITableViewCell
@property(nonatomic, strong)WJActionBlock payRightNowBlock;
@property(nonatomic, strong)WJActionBlock cancelOrderBlock;
@property(nonatomic, strong)WJActionBlock deleteOrderBlock;
@property(nonatomic, strong)WJActionBlock buyAgainBlock;

-(void)configDataWithOrder:(WJOrderModel *)order;
@end
