//
//  WJRefundPickerView.h
//  jf_store
//
//  Created by reborn on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLogisticsCompanyModel.h"
@class WJRefundPickerView;

@protocol WJRefundPickerViewDelegate <NSObject>

-(void)refundPickerView:(WJRefundPickerView *)refundPickerView clickCancelButton:(UIButton *)cancelButton;

-(void)refundPickerView:(WJRefundPickerView *)refundPickerView clickConfirmButtonWithLogisticsCompanyModel:(WJLogisticsCompanyModel *)logisticsCompanyModel;

@end

@interface WJRefundPickerView : UIView
@property(nonatomic,weak)id <WJRefundPickerViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *expressListArray;

@end
