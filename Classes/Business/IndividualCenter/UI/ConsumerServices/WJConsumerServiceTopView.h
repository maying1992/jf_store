//
//  WJConsumerServiceTopView.h
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJServiceCenterQueryModel.h"
@interface WJConsumerServiceTopView : UIView

@property(nonatomic,strong)WJActionBlock rechargeRedIntegralBlock;

-(void)configDataWithModel:(WJServiceCenterQueryModel *)model;

@end
