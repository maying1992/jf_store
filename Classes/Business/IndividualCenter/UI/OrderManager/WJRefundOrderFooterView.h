//
//  WJRefundOrderFooterView.h
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderModel.h"

@interface WJRefundOrderFooterView : UITableViewHeaderFooterView

@property(nonatomic, strong)WJActionBlock confirmRefundBlock;

-(void)configDataWithOrder:(WJOrderModel *)order;

@end
