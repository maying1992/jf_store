//
//  WJSelectPickerView.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJAreaModel.h"

@class WJSelectPickerView;
@protocol WJSelectPickerViewDelegate <NSObject>

-(void)selectPickerView:(WJSelectPickerView *)selectPickerView clickCancelButton:(UIButton *)cancelButton;

-(void)selectPickerView:(WJSelectPickerView *)selectPickerView clickConfirmButtonWithProvince:(WJAreaModel *)selectProvince city:(WJAreaModel *)selectCity  district:(WJAreaModel *)selectDistrict;


@end

@interface WJSelectPickerView : UIView
@property(nonatomic,weak)id<WJSelectPickerViewDelegate>delegate;
@end
