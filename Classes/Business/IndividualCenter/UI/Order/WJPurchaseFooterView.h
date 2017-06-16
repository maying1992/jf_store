//
//  WJPurchaseFooterView.h
//  jf_store
//
//  Created by reborn on 17/5/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderModel.h"

@interface WJPurchaseFooterView : UITableViewHeaderFooterView
@property(nonatomic, strong)WJActionBlock payRightNowBlock;
@property(nonatomic, strong)WJActionBlock cancelOrderBlock;
@property(nonatomic, strong)WJActionBlock deleteOrderBlock;
@property(nonatomic, strong)WJActionBlock checkLogisticseBlock;
@property(nonatomic, strong)WJActionBlock refundBlock;
@property(nonatomic, strong)WJActionBlock refundDetailBlock;
@property(nonatomic, strong)WJActionBlock buyAgainBlock;
@property(nonatomic, strong)WJActionBlock finishBlock;
@property(nonatomic, strong)WJActionBlock cancelRefundBlock;
-(void)configDataWithOrder:(WJOrderModel *)order;

@end
