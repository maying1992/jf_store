//
//  WJOrderFooterView.h
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderModel.h"
@interface WJOrderFooterView : UITableViewHeaderFooterView
@property(nonatomic, strong)WJActionBlock deliverGoodsBlock;
@property(nonatomic, strong)WJActionBlock confirmRefundBlock;

-(void)configDataWithOrder:(WJOrderModel *)order;
@end
