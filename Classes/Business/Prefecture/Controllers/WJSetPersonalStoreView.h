//
//  WJSetPersonalStoreView.h
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WJSetPersonalStoreView : UIView
@property(nonatomic,strong)UITextField               *storeNameTextField;
@property(nonatomic,strong)UITextField               *storeTypeTextField;
@property(nonatomic,strong)UITextField               *phoneTextField;
@property(nonatomic,strong)UITextField               *regionTextField;
@property(nonatomic,strong)UITextField               *detailAddressTextField;
@property(nonatomic,strong)UITextField               *legalPersonIDCardTextField;
@property(nonatomic,strong)UIButton                  *frontIdCardButton;
@property(nonatomic,strong)UIButton                  *backIdCardButton;
@property(nonatomic,strong)UIButton                  *submitApplyButton;

@property(nonatomic, strong)WJActionBlock            confirmButtonBlock;
@end
