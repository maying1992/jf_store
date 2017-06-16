//
//  WJPurchaseOrderCell.h
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJProductModel.h"
@interface WJPurchaseOrderCell : UITableViewCell

- (void)configDataWithProduct:(WJProductModel *)product;

@end
