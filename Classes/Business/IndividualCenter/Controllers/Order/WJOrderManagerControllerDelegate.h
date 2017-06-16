//
//  WJOrderManagerControllerDelegate.h
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#ifndef WJOrderManagerControllerDelegate_h
#define WJOrderManagerControllerDelegate_h

#import "WJOrderModel.h"

@protocol WJOrderManagerControllerDelegate <NSObject>

-(void)deliverGoodsWithOrder:(WJOrderModel *)order;   //发货

-(void)confirmRefundWithOrder:(WJOrderModel *)order; //确认退款


@end


#endif /* WJOrderManagerControllerDelegate_h */
